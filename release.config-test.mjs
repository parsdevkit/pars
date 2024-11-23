import { conventionalCommitsParser } from "conventional-commits-parser";

const parserOpts = {
    noteKeywords: [
        "BREAKING CHANGES",
        "BREAKING CHANGE",
        "DEPRECATE",
        "NEW",
        "HIGHLIGHT",
    ],
};

const commitMessage = `
fix(api): Resolve 500 error on user creation

This fixes a bug where creating a user would throw a 500 error due to a missing field validation.

BREAKING CHANGES: User creation API now requires an email address.
DEPRECATE: User creation API with phone number deprecated.
`;

const parsed = conventionalCommitsParser.sync(commitMessage, parserOpts);

console.log(parsed.notes);