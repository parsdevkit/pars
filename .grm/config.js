module.exports = {
    appName: "Pars",
    output: "CHANGELOG.md",
    noteTypes: [
        {
            sign: "!",
            type: "breaking-change",
            terms: ["BREAKING CHANGE", "BREAKING CHANGES", "BREAKING"],
            title: "⚠️ BREAKING CHANGE"
        },
        {
            sign: "+",
            type: "new",
            terms: ["NEW"],
            title: "🆕 NEW"
        },
        {
            sign: "~",
            type: "change",
            terms: ["CHANGE", "CHANGES"],
            title: "🔄 CHANGE"
        },
        {
            sign: "-",
            type: "deprecate",
            terms: ["DEPRECATE", "DEPRECATION"],
            title: "📉 DEPRECATE"
        },
        {
            sign: "?",
            type: "experimental",
            terms: ["EXPERIMENTAL"],
            title: "🔬 EXPERIMENTAL"
        },
        {
            sign: "*",
            type: "highlight",
            terms: ["HIGHLIGHT", "HIGHLIGHTS"],
            title: "🌟 KEY HIGHLIGHTS"
        },
        {
            sign: "",
            type: "known-issue",
            terms: ["KNOWN ISSUE", "KNOWN ISSUES", "ISSUE", "ISSUES"],
            title: "🐛 KNOWN ISSUES"
        }
    ],
    commitTypes: [
        {
            type: "feature",
            terms: ["feat"],
            title: "✨ Features & Improvements"
        },
        {
            type: "bug-fix",
            terms: ["fix"],
            title: "🐞 Bug Fixes"
        },
        {
            type: "documentation",
            terms: ["docs"],
            title: "📚 Documentation"
        },
        {
            type: "style",
            terms: ["style"],
            title: "🎨 Code Style"
        },
        {
            type: "refactor",
            terms: ["refactor"],
            title: "♻️ Refactoring"
        },
        {
            type: "performance",
            terms: ["perf"],
            title: "🚀 Performance Improvements"
        },
        {
            type: "test",
            terms: ["test"],
            title: "🧪 Tests"
        },
        {
            type: "ci-cd",
            terms: ["ci"],
            title: "🔄 CI/CD"
        },
        {
            type: "chore",
            terms: ["chore"],
            title: "🔧 Maintenance Tasks"
        },
    ],
    linkTypes: [
        {
            type: "basic",
            sign: ["#"],
            title: "Linked to"
        },
        {
            type: "closed",
            terms: ["Closes", "Closed"],
            title: "Closed"
        },
        {
            type: "fixed",
            terms: ["Fixes", "Fixed"],
            title: "Fixed"
        },
        {
            type: "resolved",
            terms: ["Resolves", "Resolved"],
            title: "Resolved"
        },
        {
            type: "related",
            terms: ["Related", "Related to"],
            title: "Related to"
        },
        {
            type: "connects",
            terms: ["Connects", "Connects to"],
            title: "Connects to"
        }
    ],
    mentionTypes: [
        {
            type: "signed-off-by",
            terms: ["Signed-off-by"],
            title: "Signed Off By"
        },
        {
            type: "acked-by",
            terms: ["Acked-by"],
            title: "Acknowledged By"
        },
        {
            type: "reviewed-by",
            terms: ["Reviewed-by"],
            title: "Reviewed By"
        },
        {
            type: "helped-by",
            terms: ["Helped-by"],
            title: "Helped By"
        },
        {
            type: "co-authored-by",
            terms: ["Co-authored-by"],
            title: "Co-authored-by"
        }
    ],
    fileGroups: {
        Code: ["src/", "plugins/", "pkg/", "cmake/", "build/", "bin/", "sysmodules/", "modules/"],
        Docs: ["docs/", ".github/", ".config/", ".vscode/", "README.md", "README.tr.md", "CONTRIBUTING.md", "CODE_OF_CONDUCT.md", "CHANGELOG.md", "release.config.mjs"],
        Tests: ["tests/", "data/", "cache/", "temp/", "drafts/", "log/"],
        Configurations: ["config/", ".editorconfig", ".env", ".gitignore", ".gitmodules", ".gitattributes", ".golangci.yml", "Dockerfile", "Makefile", "CMakeLists.txt", "package.json", "package-lock.json", "t.txt"],
        Assets: ["assets/", "dist/", "templates/"]
    },
    allowedBranches: ['dev', 'test', 'release/*', 'main'],
    allowedChannels: ['beta', 'rc', 'alpha', 'stable'],
    options: {//groupping, sorting, filtering, limiting
        commits: {
            sort: "date"
        }
    },
    helpers: {
        groupBy(array, key, config) {
            return array.reduce((result, item) => {
                const groupKey = key.split('.').reduce((acc, part) => acc && acc[part], item);

                if (!result[groupKey]) {

                    const matchingType = config.commitTypes.find(ct => ct.terms.includes(groupKey));
                    const typeTitle = matchingType ? matchingType.title : "Other Changes";

                    result[groupKey] = {
                        title: typeTitle,
                        items: [] // Gruplanmış öğeler
                    };
                }

                // Öğeyi ilgili gruba ekle
                result[groupKey].items.push(item);
                return result;
            }, {});
        },
        groupByNotes(array, config, includeUnmatched = true) {
            return array.reduce((result, item) => {
                if (!item.notes || item.notes.length === 0) return result; // Eğer notes boşsa geç

                item.notes.forEach(note => {
                    const groupKey = note.type;
                    const matchingType = config.noteTypes.find(nt => nt.type === groupKey);

                    // Eğer tür config'de yoksa ve includeUnmatched false ise atla
                    if (!matchingType && !includeUnmatched) return;

                    if (!result[groupKey]) {
                        const typeTitle = matchingType ? matchingType.title : groupKey; // Varsayılan olarak kendi türünü kullan

                        result[groupKey] = {
                            title: typeTitle,
                            items: [] // Gruplanmış notlar
                        };
                    }

                    // Notu ilgili gruba ekle
                    result[groupKey].items.push({
                        note,
                        commit: item
                    });
                });

                return result;
            }, {});
        }

    }


};