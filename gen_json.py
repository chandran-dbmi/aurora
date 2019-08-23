import os
import glob
import json
from xml.etree import ElementTree as ET

def read_clin(file):
    clin_data = {}

    json_data = open(file).read()
    data = json.loads(json_data)

    for elem in data:
        clin_data[elem['patient_barcode']] = elem

    return clin_data

def read_rnaseq(file):
    # rseq_files = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
    rseq_files = {}
    with open(file, 'r') as fileref:
        next(fileref) # skip header

        for line in fileref:
            lvls1 = dict.fromkeys(['level', 'file_type', 'file_names'])
            lvls2 = dict.fromkeys(['level', 'file_type', 'file_names'])
            lvls3 = dict.fromkeys(['level', 'file_type', 'file_names'])
            files = []
            cols = line.split("\t")

            lvls1['level'] = 'level1'
            lvls1['file_type'] = 'fastq'
            lvls1['file_names'] = [cols[4], cols[5]]
            files.append(lvls1)

            # level2 BAMs
            lvls2['level'] = 'level2'
            lvls2['file_type'] = 'BAM'
            lvls2['file_names'] = [cols[2], cols[3]]
            files.append(lvls2)

            # level3 BAMs
            lvls3['level'] = 'level3'
            lvls3['file_type'] = 'quant'
            lvls3['file_names'] = [cols[6]]
            files.append(lvls3)

            # store in a dict
            rseq_files[cols[1]] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
            rseq_files[cols[1]]['files'] = files
            rseq_files[cols[1]]['seq_type'] = 'RNA-Seq'
            rseq_files[cols[1]]['analysis_type'] = 'RNA-Seq'
            # rseq_files[cols[1]] = files
    return rseq_files

def read_dnaseq(file):
    # rseq_files = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
    dseq_files = {}
    with open(file, 'r') as fileref:
        next(fileref) # skip header
        for line in fileref:
            cols = line.split("\t")

            wes = dict.fromkeys(['lvls1', 'lvls2'])
            wgs = dict.fromkeys(['lvls1', 'lvls2'])

            wes['lvls1'] = dict.fromkeys(['level', 'file_type', 'file_names'])
            wes['lvls2'] = dict.fromkeys(['level', 'file_type', 'file_names'])

            wgs['lvls1'] = dict.fromkeys(['level', 'file_type', 'file_names'])
            wgs['lvls2'] = dict.fromkeys(['level', 'file_type', 'file_names'])

            files_wes = []
            files_wgs = []
            cols = line.split("\t")

            # if there is no entry for aliquot barcode
            if (cols[5] in dseq_files):
                dseq_files[cols[5]]['WES']['files'][0]['file_names'].append(cols[7])
                dseq_files[cols[5]]['WES']['files'][1]['file_names'].append(cols[9])

                dseq_files[cols[5]]['WGS']['files'][0]['file_names'].append(cols[8])
                dseq_files[cols[5]]['WGS']['files'][1]['file_names'].append(cols[10])

            
            else:

                # level1 BAMs
                # wes
                wes['lvls1']['level'] = 'level1'
                wes['lvls1']['file_type'] = 'BAMs'
                wes['lvls1']['file_names'] = [cols[7]]
                files_wes.append(wes['lvls1'])
                # wgs
                wgs['lvls1']['level'] = 'level1'
                wgs['lvls1']['file_type'] = 'BAMs'
                wgs['lvls1']['file_names'] = [cols[8]]
                files_wgs.append(wgs['lvls1'])

                # level2 VCFs
                # wes
                wes['lvls2']['level'] = 'level2'
                wes['lvls2']['file_type'] = 'VCF'
                wes['lvls2']['file_names'] = [cols[9]]
                files_wes.append(wes['lvls2'])
                # wgs
                wgs['lvls2']['level'] = 'level2'
                wgs['lvls2']['file_type'] = 'VCF'
                wgs['lvls2']['file_names'] = [cols[10]]
                files_wgs.append(wgs['lvls2'])

                # store in a dict
                dseq_files[cols[5]] = dict.fromkeys(['WES', 'WGS'])
                dseq_files[cols[5]]['WES'] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
                dseq_files[cols[5]]['WGS'] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])

                # wes
                dseq_files[cols[5]]['WES']['files'] = files_wes
                dseq_files[cols[5]]['WES']['seq_type'] = 'DNA-Seq'
                dseq_files[cols[5]]['WES']['analysis_type'] = 'WES'
                # wgs
                dseq_files[cols[5]]['WGS']['files'] = files_wgs
                dseq_files[cols[5]]['WGS']['seq_type'] = 'DNA-Seq'
                dseq_files[cols[5]]['WGS']['analysis_type'] = 'WGS'

    return dseq_files


def read_methseq(file):
    # rseq_files = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
    mseq_files = {}
    with open(file, 'r') as fileref:
        next(fileref) # skip header
        aliquot_list = []
        for line in fileref:
            cols = line.split("\t")

            lvls1 = dict.fromkeys(['level', 'file_type', 'file_names'])
            lvls2 = dict.fromkeys(['level', 'file_type', 'file_names'])
            lvls3 = dict.fromkeys(['level', 'file_type', 'file_names'])
            files = []
            cols = line.split("\t")

            if (cols[3] in mseq_files):
                mseq_files[cols[3]]['files'][0]['file_names'].append(cols[5])

            else:
                lvls1['level'] = 'level1'
                lvls1['file_type'] = 'idat'
                lvls1['file_names'] = [cols[5]]
                files.append(lvls1)

                # level2 BAMs
                lvls2['level'] = 'level2'
                lvls2['file_type'] = 'tsv'
                lvls2['file_names'] = [cols[6]]
                files.append(lvls2)

                # level3 BAMs
                lvls3['level'] = 'level3'
                lvls3['file_type'] = 'tsv'
                lvls3['file_names'] = [cols[7]]
                files.append(lvls3)

                # store in a dict
                mseq_files[cols[3]] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
                mseq_files[cols[3]]['files'] = files
                mseq_files[cols[3]]['seq_type'] = 'DNA-Seq'
                mseq_files[cols[3]]['analysis_type'] = 'Methylation'

    return mseq_files


def xml_to_json(root, clin_data, rseq_files, dseq_files, mseq_files):
    # declare namespaces of xml
    ns = {'bio' : '{http://tcga.nci/bcr/xml/biospecimen/2.7}',
            'shared' : '{http://tcga.nci/bcr/xml/shared/2.7}',
            'admin': '{http://tcga.nci/bcr/xml/administration/2.7}'}

    for child in root:
        if child.tag == (ns['bio']+'patient'):
            # patient node
            patient =dict.fromkeys(['clin', 'samples'])
            # patient['patient_id'] = {}
            patient['clin'] = {} #assigned at patient barcode
            patient['samples'] = {}
            for patient_child in child:
                aur_samples = []
                # patient
                # if patient_child.tag == (ns['shared']+'patient_id'):
                #     patient['patient_id']['patient'] = patient_child.text
                # bcr_patient_barcode
                if patient_child.tag == (ns['shared']+'bcr_patient_barcode'):
                    # patient['patient_id']['bcr_patient_barcode'] = patient_child.text
                    #assign clin data
                    if patient_child.text in clin_data:
                        patient['clin'] = clin_data[patient_child.text]
                # bcr_patient_uuid
                # if patient_child.tag == (ns['shared']+'bcr_patient_uuid'):
                #     patient['patient_id']['bcr_patient_uuid'] = patient_child.text

                # look for samples node
                if patient_child.tag == (ns['bio']+'samples'):
                    for samples in patient_child:
                        aur_sample = dict.fromkeys(['identifiers', 'sample_info', 'portion'])
                        aur_sample['identifiers'] = {}
                        aur_sample['sample_info'] = {}
                        aur_sample['portion'] = {}

                        for sample in samples:
                            aur_portions = []
                            if sample.tag == (ns['admin']+'alternate_identifiers'):
                                aur_sample['identifiers']['aurora_sample_identifier'] = sample[0].text
                            if sample.tag == (ns['bio']+'sample_type'):
                                aur_sample['sample_info']['sample_type'] = sample.text
                            if sample.tag == (ns['bio']+'tissue_type'):
                                aur_sample['sample_info']['tissue_type'] = sample.text
                            if sample.tag == (ns['bio']+'composition'):
                                aur_sample['sample_info']['composition'] = sample.text
                            if sample.tag == (ns['bio']+'bcr_sample_barcode'):
                                aur_sample['identifiers']['bcr_sample_barcode'] = sample.text
                            if sample.tag == (ns['bio']+'bcr_sample_uuid'):
                                aur_sample['identifiers']['bcr_sample_uuid'] = sample.text
                            if sample.tag == (ns['bio']+'is_ffpe'):
                                if sample.text == "NO":
                                    aur_sample['sample_info']['preservation_method'] = 'Fresh'
                                else:
                                    aur_sample['sample_info']['preservation_method'] = 'FFPE'
                            if sample.tag == (ns['bio']+'portions'):
                                for portions in sample:
                                    aur_portion = dict.fromkeys(['identifiers', 'analyte'])
                                    aur_portion['identifiers'] = {}
                                    aur_portion['analyte'] = {}

                                    for portion in portions:
                                        aur_analytes = []
                                        if portion.tag == (ns['bio']+'bcr_portion_barcode'):
                                            aur_portion['identifiers']['bcr_portion_barcode'] = portion.text
                                        if portion.tag == (ns['bio']+'bcr_portion_uuid'):
                                            aur_portion['identifiers']['bcr_portion_uuid'] = portion.text
                                        if portion.tag == (ns['bio']+'analytes'):
                                            for analytes in portion:
                                                aur_analyte = dict.fromkeys(['identifiers', 'aliquot'])
                                                aur_analyte['identifiers'] = {}
                                                aur_analyte['aliquot'] = {}

                                                for analyte in analytes:
                                                    aur_aliquots = []
                                                    if analyte.tag == (ns['bio']+'analyte_type'):
                                                        aur_analyte['identifiers']['analyte_type'] = analyte.text
                                                    if analyte.tag == (ns['bio']+'bcr_analyte_barcode'):
                                                        aur_analyte['identifiers']['bcr_analyte_barcode'] = analyte.text
                                                    if analyte.tag == (ns['bio']+'bcr_analyte_uuid'):
                                                        aur_analyte['identifiers']['bcr_analyte_uuid'] = analyte.text
                                                    if analyte.tag == (ns['bio']+'aliquots'):

                                                        for aliquots in analyte:
                                                            aur_aliquot = dict.fromkeys(['identifiers', 'seq_info'])
                                                            aur_aliquot['identifiers'] = {}
                                                            aur_aliquot['seq_info'] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])

                                                            # aur_aliquot['seq_info']['files'] = 'None'
                                                            # aur_aliquot['seq_info']['analysis_type'] = 'None'
                                                            # aur_aliquot['seq_info']['seq_type'] = 'None'
                                                            for aliquot in aliquots:
                                                                if aliquot.tag == (ns['bio']+'bcr_aliquot_barcode'):
                                                                    aur_aliquot['identifiers']['bcr_aliquot_barcode'] = aliquot.text
                                                                    # include rnaseq files if available
                                                                    if aliquot.text in rseq_files:
                                                                        aur_aliquot['seq_info']['files'] = rseq_files[aliquot.text]['files']
                                                                        aur_aliquot['seq_info']['analysis_type'] = rseq_files[aliquot.text]['analysis_type']
                                                                        aur_aliquot['seq_info']['seq_type'] = rseq_files[aliquot.text]['seq_type']
                                                                    if aliquot.text in dseq_files:
                                                                        # overriding the previous dict declaration to suit WES and WGS
                                                                        aur_aliquot['seq_info'] = dict.fromkeys(['WES', 'WGS'])
                                                                        aur_aliquot['seq_info']['WES'] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])
                                                                        aur_aliquot['seq_info']['WGS'] = dict.fromkeys(['analysis_type', 'seq_type', 'files'])

                                                                        # wes
                                                                        aur_aliquot['seq_info']['WES']['files'] = dseq_files[aliquot.text]['WES']['files']
                                                                        aur_aliquot['seq_info']['WES']['seq_type'] = dseq_files[aliquot.text]['WES']['seq_type']
                                                                        aur_aliquot['seq_info']['WES']['analysis_type'] = dseq_files[aliquot.text]['WES']['analysis_type']
                                                                        # wgs
                                                                        aur_aliquot['seq_info']['WGS']['files'] = dseq_files[aliquot.text]['WGS']['files']
                                                                        aur_aliquot['seq_info']['WGS']['seq_type'] = dseq_files[aliquot.text]['WGS']['seq_type']
                                                                        aur_aliquot['seq_info']['WGS']['analysis_type'] = dseq_files[aliquot.text]['WGS']['analysis_type']

                                                                    if aliquot.text in mseq_files:
                                                                        aur_aliquot['seq_info']['files'] = mseq_files[aliquot.text]['files']
                                                                        aur_aliquot['seq_info']['analysis_type'] = mseq_files[aliquot.text]['analysis_type']
                                                                        aur_aliquot['seq_info']['seq_type'] = mseq_files[aliquot.text]['seq_type']

                                                                if aliquot.tag == (ns['bio']+'bcr_aliquot_uuid'):
                                                                    aur_aliquot['identifiers']['bcr_aliquot_uuid'] = aliquot.text

                                                            aur_aliquots.append(aur_aliquot)
                                                        aur_analyte['aliquot'] = aur_aliquots
                                                        # print(json.dumps(aur_analyte, indent=2))
                                                aur_analytes.append(aur_analyte)
                                            aur_portion['analyte'] = aur_analytes
                                            # print(json.dumps(aur_portion, indent=2))
                                    aur_portions.append(aur_portion)
                                aur_sample['portion'] = aur_portions
                                # print(json.dumps(aur_sample, indent=2))
                        # print("Samples:", aur_sample)
                        aur_samples.append(aur_sample)
                    patient['samples'] = aur_samples
                    return patient




### Main ###
## read clinical data_file
clin_data = read_clin("input/Aurora-ClincialData_2019-04-05.json")

## read text files
rseq_files = read_rnaseq("input/RNA-Seq_with_AUR_ID.txt") # rna-seq
dseq_files = read_dnaseq("input/DNA-Seq_with_AUR_ID.txt") # dna-seq
mseq_files = read_methseq("input/Methyl-Seq_with_AUR_ID.txt") # meth-seq

## read xml files

for xml_file in glob.glob('../../XML/nationwidechildrens.org_biospecimen*.xml'):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    # pass the root to xml_to_json function
    patient_json = xml_to_json(root, clin_data, rseq_files, dseq_files, mseq_files)

    ## write JSON file
    outfile_name = patient_json['clin']['patient_barcode'] + '.json'
    print("Generating JSON for:", outfile_name)
    outfile_path = os.path.join('..','..','JSON',outfile_name)

    out_json = open(outfile_path, "w")
    out_json.write(json.dumps(patient_json, indent=2))
    out_json.close()
