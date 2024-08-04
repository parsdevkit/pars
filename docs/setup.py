from setuptools import setup, find_packages

setup(
    name="mkdocs-plugins",
    version="0.1",
    packages=find_packages(),
    include_package_data=True,
    package_data={
        '': ['assets/stylesheets/*.css'],
    },
    install_requires=[
        "mkdocs>=1.0.4",
        "Jinja2>=2.10.1"
    ],
    entry_points={
        "mkdocs.plugins": [
            "tree = extensions.mkdocs_tree_plugin.tree:TreePlugin"
        ]
    }
)
