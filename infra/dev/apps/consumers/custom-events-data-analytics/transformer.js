'use strict';
console.log('Loading function');


exports.handler = (event, context, callback) => {
    let success = 0;
    let failure = 0;

    const output = event.records.map((record) => {

        const payload = (Buffer.from(record.data, 'base64')).toString('ascii');
        const json_doc = JSON.parse(payload.replace("NaN","null"));

        if (Object.keys(json_doc).length > 0) {
            delete json_doc.originLevel2;
            delete json_doc.userName;
            delete json_doc.userId;
            delete json_doc.splitTestRunName;
            delete json_doc.customEventOriginLevel2;
            delete json_doc.c_loading_time;
            delete json_doc.c_pagelanguage;
            delete json_doc.c_card_type;
            delete json_doc.c_browser_time;
            delete json_doc.c_pageaudience;
            delete json_doc.c_workgroup;
            delete json_doc.success++;
            return {
                recordId: record.recordId,
                result: 'Ok',
                data: (Buffer.from(JSON.stringify(json_doc))).toString('base64'),
            };
        } else {
            failure++;
            return {
                recordId: record.recordId,
                result: 'ProcessingFailed',
                data: record.data,
            };
        }
    });
    console.log(`Processing completed.  Successful records ${success}, Failed records ${failure}.`);
    callback(null, { records: output });
};
