#!/usr/bin/env snakemake
'''
Ed Mountjoy (June 2018)

'''

from snakemake.remote.FTP import RemoteProvider as FTPRemoteProvider
from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider

# Load configuration
configfile: "configs/config.yaml"
tmpdir = config['temp_dir']
keep_local = True

targets = []

# Make targets for top loci table
targets.append(
    'output/ot_genetics_toploci_table.{version}.tsv'.format(version=config['version'])
    )
targets.append(GSRemoteProvider().remote(
    '{gs_dir}/{version}/ot_genetics_toploci_table.{version}.tsv'.format(gs_dir=config['gs_dir'],
                                                                        version=config['version'])
    ))

# Make targets for study table
targets.append(
    'output/ot_genetics_studies_table.{version}.tsv'.format(version=config['version'])
    )
targets.append(GSRemoteProvider().remote(
    '{gs_dir}/{version}/ot_genetics_studies_table.{version}.tsv'.format(gs_dir=config['gs_dir'],
                                                                        version=config['version'])
    ))

# Make targets for finemapping table
targets.append(
    'output/ot_genetics_finemapping_table.{version}.tsv.gz'.format(version=config['version'])
    )
targets.append(GSRemoteProvider().remote(
    '{gs_dir}/{version}/ot_genetics_finemapping_table.{version}.tsv.gz'.format(gs_dir=config['gs_dir'],
                                                                            version=config['version'])
    ))

# Trigger making of targets
rule all:
    input:
        targets

# Add workflows
include: 'scripts/top_loci_table.Snakefile'
include: 'scripts/study_table.Snakefile'
include: 'scripts/finemapping_table.Snakefile'
