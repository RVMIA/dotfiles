import portage

# Initialize portage settings and trees
settings = portage.config(clone=portage.settings)
trees = portage.create_trees(
    config_root=settings["EROOT"], target_root=settings["ROOT"])

# Get the portdb API for the packages database
portdb = portage.db[portage.root]["vartree"].dbapi

package_dependencies = {}

# Iterate through all installed packages
for cp in portdb.cp_all():
    try:
        # Get package atom for dependency resolution
        atoms = portdb.match(cp)
        if not atoms:
            continue
        # Get dependency information
        for atom in atoms:
            deps = portdb.aux_get(atom, ["RDEPEND", "DEPEND", "PDEPEND"])
            all_deps = deps[0].split() + deps[1].split() + deps[2].split()
            package_dependencies[cp] = len(set(all_deps))
    except portage.exception.InvalidPackageName:
        print(f"Invalid package name encountered: {cp}")
        continue
    except Exception as e:
        print(f"An error occurred with package {cp}: {e}")
        continue

# Sort packages by the number of dependencies
sorted_packages = sorted(package_dependencies.items(),
                         key=lambda x: x[1], reverse=True)

# Print the installed packages with the most dependencies
# Adjust the slice to show more/less results
for cp, dep_count in sorted_packages:
    print(f"{cp}: {dep_count} dependencies")
