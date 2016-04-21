cd "${INSTALLDIR}/${NAME}/babycenter/"
manage="${VENV}/bin/python ${INSTALLDIR}/${NAME}/babycenter/manage.py"

$manage migrate --settings=babycenter.settings.production

# process static files
$manage compress --settings=babycenter.settings.production
$manage collectstatic --noinput --settings=babycenter.settings.production

# compile i18n strings
$manage compilemessages --settings=babycenter.settings.production
