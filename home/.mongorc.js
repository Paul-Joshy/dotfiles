EDITOR="vim"

function getMasterDataCount(){
	return db.scheme.find({"eligibility.entitlementText": /masterDataObj/}).count()
}

function vdpc(){
	return db.version_publish_details.find().count()
}

function vdc(){
	return db.version_details.find().count()
}
