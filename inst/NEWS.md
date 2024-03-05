# spaceRATScaffolds 0.99.3

* Update TCGA and GTEx scaffolds
* Scaffolds will now include rank calculations, scaling settings, and `spaceRAT`
version.
* Scaffolds are now managed using `SciDataFlow`

# spaceRATScaffolds 0.99.2

* Passes `devtools::check()` with only 1 note (package size)
* allScaffolds are now extracted from Zenodo instead of being a manually 
generated object
* Add descriptions for TCGA and GTEx scaffolds
* Optional store parameter in `getScaffold`
* Put scaffold on Zenodo
* Create `getScaffold` function that gets scaffold from Zenodo

# spaceRATScaffolds 0.99.1

* Initiate scaffold versioning
* Add `allScaffolds` object to manage scaffolds

# spaceRATScaffolds 0.99.0

* Add UMAP to DMAP scaffold
* Revamp scaffolds to be lists instead of their own data type
* Prep for Bioc submission.
* Include DMAP scaffold.
* Include DMAP and Ilaria example data.
* Include Homo sapiens and Mus musculus gene ID converters.
* Added a `NEWS.md` file to track changes to the package.
