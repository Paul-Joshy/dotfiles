EDITOR="vim"

// Sankalp stuff
// function getMasterDataCount(){
// 	return db.scheme.find({"eligibility.entitlementText": /masterDataObj/}).count()
// }

// function vdpc(){
// 	return db.version_publish_details.find().count()
// }

// function vdc(){
// 	return db.version_details.find().count()
// }

// Micropearls
function resetdb(){
	db.application_details.drop()
	db.download_details.drop()
	db.changes_details.drop()
	db.file_details.drop()
	db.tips_and_pearls.drop()
	db.tips_and_pearls_techniques.drop()
	db.version_publish_details.drop()
	db.versions_details.drop()
	db.version_publish_details.insert({"version": 1, "status": "Unpublished"})
	return
}

function resetversion(){
	db.version_publish_details.drop()
	db.versions_details.drop()
	db.version_publish_details.insert({"version": 1, "status": "Unpublished"})
	return
}

