
// new types: local, misc
// new noteKeywords "BREAKING CHANGE", "BREAKING CHANGES", "BREAKING", "NEW", "DEPRECATE", "COMPATIBILITY", "DEPENDENCY", "CONFIGURATION", "NOTE", "KNOWN ISSUE", "FUTURE", "HIGHLIGHT"


import { generateNotes as defaultGenerateNotes } from "@semantic-release/release-notes-generator";
const profileUrlCache = new Map();
const repoUrl = "https://github.com/parsdevkit/pars"

async function prepareProfileUrls(commits) {
    for (const commit of commits) {
        if (commit.author && commit.author.email) {
            if (!profileUrlCache.has(commit.author.email)) {
                const profileUrl = await getGitHubProfileUrl(commit.author.email, process.env.GITHUB_TOKEN);
                profileUrlCache.set(commit.author.email, profileUrl || commit.root.host);
            }
            commit.author.profileUrl = profileUrlCache.get(commit.author.email);
        } else {
            commit.author = commit.author || {};
            commit.author.profileUrl = commit.root.host;
        }
    }
}


async function getGitHubProfileUrl(email, token) {
    const url = `https://api.github.com/search/users?q=${email}`;

    try {
        const response = await fetch(url, {
            headers: {
                Authorization: `token ${token}`
            }
        });

        if (!response.ok) {
            console.error("API Request Failed:", response.statusText);
            return null;
        }

        const data = await response.json();
        if (data.total_count > 0 && data.items[0].html_url) {
            return data.items[0].html_url;
        } else {
            console.warn("No GitHub profile found for email:", email);
            return null;
        }
    } catch (error) {
        console.error("Error fetching GitHub profile:", error);
        return null;
    }
}

async function generateCustomNotes(pluginConfig, context) {
    const commits = context.commits;
    await prepareProfileUrls(commits);

    pluginConfig.preset = "conventionalcommits"
    pluginConfig.presetConfig = {
        types: [
            {
                type: "feat",
                section: "✨ Features & Improvements",
                hidden: false
            },
            {
                type: "fix",
                section: "🐞 Bug Fixes",
                hidden: false
            },
            {
                type: "docs",
                section: "📚 Documentation",
                hidden: false
            },
            {
                type: "style",
                section: "🎨 Code Style",
                hidden: false
            },
            {
                type: "refactor",
                section: "♻️ Refactoring",
                hidden: false
            },
            {
                type: "perf",
                section: "🚀 Performance Improvements",
                hidden: false
            },
            {
                type: "test",
                section: "🧪 Tests",
                hidden: false
            },
            {
                type: "ci",
                section: "🔄 CI/CD",
                hidden: false
            },
            {
                type: "chore",
                section: "🔧 Maintenance Tasks",
                hidden: true
            }
        ]
    };
    pluginConfig.parserOpts = {
        noteKeywords: [
            "BREAKING CHANGES",
            "BREAKING CHANGE",
            "BREAKING",
        ],
    };
    pluginConfig.writerOpts = {
        ...pluginConfig.writerOpts,
        commitsSort: ["subject", "scope"],
        commitPartial: (commit, context) => {
            console.log(`commit: ${JSON.stringify(commit)}`)
            const scope = commit.scope ? ` **${commit.scope}**: ` : '';
            const subject = commit.subject ? `${commit.subject}` : '';
            const authorName = commit.author?.name || "🌀 **Phantom Ninja** 🥷";
            const authorProfileUrl = commit.author?.profileUrl || commit.root.host;
            const author = ` (by [@${authorName}](${authorProfileUrl}))`;
            const shortHash = commit.hash ? commit.hash.slice(0, 7) : null;
            const hash = shortHash ? ` ([${shortHash}](${commit.root.host}/${commit.root.owner}/${commit.root.repository}/commit/${commit.hash}))` : '';
            const issueLink = commit.references.length > 0
                ? ` ([#${commit.references[0].issue}](${commit.root.host}/${commit.root.owner}/${commit.root.repository}/issues/${commit.references[0].issue}))`
                : '';
            const body = commit.body ? `\n\n    ${commit.body.replace(/\n/g, '\n      ')}` : '';

            const notes = commit.notes
                .filter(note => note.title !== 'BREAKING CHANGES')
                .map(note => {
                    const noteTitle = note.title || 'Note';
                    return `\n\n    **${noteTitle}:**\n    - ${note.text.replace(/\n/g, '\n    - ')}`;
                })
                .join('');

            return `- ${scope}${subject}${author}${hash}${issueLink}${body}${notes}\n`;
        },

    };

    return defaultGenerateNotes(pluginConfig, context);
}


const branches = [
    { name: 'main' },
    { name: 'dev', prerelease: true },
    { name: 'test', prerelease: true },
    { name: 'release', prerelease: true },
];

import { execSync } from "child_process";
function getCurrentGitBranch() {
    try {
        const branch = execSync("git rev-parse --abbrev-ref HEAD", { encoding: "utf-8" }).trim();
        return branch;
    } catch (error) {
        console.error("Failed to get the current Git branch:", error);
        return null;
    }
}

const getBranchConfig = () => {


    const currentBranch = getCurrentGitBranch();
    const branchConfig = branches.find(branch => branch.name === currentBranch);

    return branchConfig && branchConfig.prerelease ? true : false;
};

const isPreRelease = getBranchConfig();

const plugins = [
    [
        "@semantic-release/commit-analyzer",
        {
            preset: "conventionalcommits",
            // releaseRules: [
            //     { type: "docs", scope: "README", release: "patch" },
            //     { type: "refactor", release: "patch" },
            //     { type: "style", release: "patch" },
            //     { tag: "breaking", release: "major" },
            //     { subject: "no-release", release: false },
            //     { subject: "!no-release", release: "patch" },
            // ],
        },
    ],
    ["@semantic-release/release-notes-generator"],
    ...(isPreRelease ? [] : ["@semantic-release/changelog"]),
];


export default {
    branches: branches,
    repositoryUrl: repoUrl,
    tagFormat: "v${version}",
    plugins: plugins,
    generateNotes: generateCustomNotes,
};
