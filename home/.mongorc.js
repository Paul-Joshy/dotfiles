EDITOR="vim"

function getMasterDataCount(){
	return db.scheme.find({"eligibility.entitlementText": /masterDataObj/}).count()
}
