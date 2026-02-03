# About
This document outlines the checklist for releasing a new version of the mod. Since the process involves multiple steps, this checklist ensures that nothing is overlooked.

# Workflow
- [ ] Create a new working branch from `main` for the update.
- [ ] Test the mod in the latest stable version of Factorio to ensure compatibility.
- [ ] Test old saves with previous mod version already installed to check migrations
- [ ] Verify that all dependencies are correctly specified in `info.json`.
- [ ] Update the mod version in `info.json` and `README.md`.
- [ ] Update the changelog with details of new features, improvements, and bug fixes using [official docs](https://lua-api.factorio.com/latest/auxiliary/changelog-format.html).

# Release
In case of any issues during this flow, you have to begin from the [Workflow](#workflow) section and make appropriate corrections.

- [ ] Create Pull Request for the working branch with description using [template](./pull-request-template.md).
- [ ] Self-review the Pull Request and merge with squash.
- [ ] Create GitHub release with notes summarizing the changes in this version using [template](./release-template.md) and version must be in format `vX.Y.Z`.
- [ ] Upload the new version to the [Factorio mod portal](https://mods.factorio.com/mod/Exoskeleton%20Mark%20II) in the `.zip` format.
- [ ] Check that description, thumbnail, and other metadata are correct on the mod portal.
- [ ] Upload the new version to the [Factorio Forum post](https://forums.factorio.com/viewtopic.php?f=93&t=39645&p=235794#p235794) in the `.zip` format