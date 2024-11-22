module.exports = {
    branches: ["main"],
    plugins: [
        "@semantic-release/commit-analyzer",
        [
            "@semantic-release/release-notes-generator",
            {
                preset: "conventionalcommits",
                presetConfig: {
                    writerOpts: {
                        // Commit bilgilerini özelleştirme
                        commitPartial: `
                - {{#if subject}}**{{subject}}**{{/if}}
                {{#if authorName}} (by @{{authorName}}){{/if}}
                {{#if hash}} ([commit]({{repoUrl}}/commit/{{hash}})){{/if}}
              `
                    }
                }
            }
        ],
        "@semantic-release/changelog",
        // [
        //     "@semantic-release/git",
        //     {
        //         assets: ["CHANGELOG.md"],
        //         message: "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
        //     }
        // ],
        // "@semantic-release/github"
    ]
};
