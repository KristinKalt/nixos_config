{ pkgs ? import <nixpkgs> {} }:
let
  my-python = pkgs.python38;
  python-with-my-packages = my-python.withPackages (p: with p; [
    numpy 
    toolz 
    pandas 
    jupyter 
    scikitlearn 
    matplotlib
    statsmodels
    patsy
    selenium
  ]);
in
pkgs.mkShell {
  buildInputs = [
    python-with-my-packages
    pkgs.geckodriver
  ];
  shellHook = ''
    PYTHONPATH=${python-with-my-packages}/lib/python${my-python.pythonVersion}/site-packages
    # maybe set more env-vars
  '';
}
