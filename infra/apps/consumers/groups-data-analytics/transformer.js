'use strict';
console.log('Loading function');


exports.handler = (event, context, callback) => {
    let success = 0;
    let failure = 0;

    const output = event.records.map((record) => {

        const payload = (Buffer.from(record.data, 'base64')).toString('ascii');
        const columns = payload.split('|');

        if (columns) {
            const result = {
                searchId: columns[0],
                datetime: columns[1],
                groupName: columns[2],
            };
            success++;
            return {
                recordId: record.recordId,
                result: 'Ok',
                data: (Buffer.from(JSON.stringify(result))).toString('base64'),
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
