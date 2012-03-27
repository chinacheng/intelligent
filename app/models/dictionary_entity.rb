class DictionaryEntity < ActiveRecord::Base
  REVIEW_MAP = {I18n.t("common.comment.open") => true, I18n.t("common.comment.close") => false}

  PASS_MAP  = {I18n.t("common.approval.pass") => true, I18n.t("common.approval.cancel") => false}

  DISPLAY_MAP = { I18n.t("common.display.show") => true, I18n.t("common.display.hide") => false}
  

  GENDER_MAP = {I18n.t("common.gender.male") => "male",I18n.t("common.gender.female") => "female"}
end
