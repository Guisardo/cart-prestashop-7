{*
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author PrestaShop SA <contact@prestashop.com>
* @copyright 2007-2019 PrestaShop SA
* @license http://opensource.org/licenses/afl-3.0.php Academic Free License (AFL 3.0)
* International Registered Trademark & Property of PrestaShop SA
*}

<form id="mp_custom_checkout" class="mp-checkout-form" method="post" action="{$redirect}">

    <div class="row frame-checkout-custom-seven">
        <div class="col-xs-12 col-md-12 col-12">
            <a class="link-checkout-custom" id="button-show-payments">{l s='Con qué tarjetas puedo pagar' mod='mercadopago'} ⌵ </a>
        </div>

        <div class="col-xs-12 col-md-12 col-12">
            <div class="frame-payments" id="frame-payments">
                {if count($credit) != 0}
                <p class="subtitle-payments">{l s='Tarjetas de crédito' mod='mercadopago'}</p>
                    {foreach $credit as $tarjeta}
                        <img src="{$tarjeta['image']|escape:'html':'UTF-8'}" class="img-fluid img-tarjetas" />
                    {/foreach}
                {/if}

                {if count($debit) != 0}
                    <p class="subtitle-payments pt-10">{l s='Tarjetas de débito' mod='mercadopago'}</p>
                    {foreach $debit as $tarjeta}
                        <img src="{$tarjeta['image']|escape:'html':'UTF-8'}" class="img-fluid img-tarjetas" />
                    {/foreach}
                {/if}
            </div>
        </div>

        {if $coupon == true}
        <div id="mercadopago-form-custom-coupon" class="col-xs-12 col-md-12 col-12">
            <h3 class="title-custom-checkout">{l s='Ingresa tu cupón de descuento' mod='mercadopago'}</h3>

            <div class="form-group">
                <div class="col-md-9 col-xs-8 pb-10 pl-0 mp-m-col">
                    <input type="text" id="couponCodeCustom" name="mercadopago_custom[coupon_code]" class="form-control mp-form-control" autocomplete="off" maxlength="24" placeholder="{l s='Ingresá tu cupón' mod='mercadopago'}" />

                    <small class="mp-sending-coupon" id="mpSendingCouponCustom">{l s='Validando cupón de descuento...' mod='mercadopago'}</small>
                    <small class="mp-success-coupon" id="mpCouponApplyedCustom">{l s='Cupón de descuento aplicado!' mod='mercadopago'}</small>
                    <small class="mp-erro-febraban" id="mpCouponErrorCustom">{l s='El código que ingresaste no es válido!' mod='mercadopago'}</small>
                    <small class="mp-erro-febraban" id="mpResponseErrorCustom">{l s='Lo sentimos, ocurrió un error. Por favor, inténtelo de nuevo.' mod='mercadopago'}</small>
                </div>

                <div class="col-md-3 col-xs-4 pb-10 pr-0 text-center mp-m-col">
                    <input type="button" class="btn btn-primary mp-btn" id="applyCouponCustom" onclick="mpCustomApplyAjax()" value="{l s='Aplicar' mod='mercadopago'}" />
                </div>
            </div>
        </div>
        {/if}

        <div id="mercadopago-form" class="col-xs-12 col-md-12 col-12">
            <h3 class="title-custom-checkout pt-20">{l s='Ingresa los datos de tu tarjeta' mod='mercadopago'}</h3>

            {if $site_id == 'MLM' || $site_id == 'MPE'}
            <div class="form-group">
                <div class="col-md-12 col-12 pb-10 px-0 mp-m-col">
                    <label for="credit_option" class="pb-5">{l s='Card Type' mod='mercadopago'} <em class="mp-required">*</em></label>
                    <select id="credit_option" class="form-control mp-form-control mp-select pointer" type="text"></select>
                </div>
            </div>
            {/if}

            <div class="form-group">
                <div class="col-md-12 col-12 pb-10 px-0 mp-m-col">
                    <label for="id-card-number" class="pb-5">{l s='Número de Tarjeta' mod='mercadopago'} <em class="mp-required">*</em></label>
                    <input id="id-card-number" data-checkout="cardNumber" type="text" class="form-control mp-form-control" onkeyup="maskInput(this, mcc);" maxlength="24" autocomplete="off" />
                    <small id="id-card-number-status" class="mp-erro-form"></small>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-12 col-12 pb-10 px-0 mp-m-col">
                    <label for="id-card-holder-name" class="pb-5">{l s='Nombre y apellido del titular de la tarjeta' mod='mercadopago'} <em class="mp-required">*</em></label>
                    <input id="id-card-holder-name" data-checkout="cardholderName" type="text" class="form-control mp-form-control" autocomplete="off" />
                    <small id="id-card-holder-name-status" class="mp-erro-form"></small>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-6 col-6 pb-20 pl-0 mp-m-col">
                    <label for="id-card-expiration" class="pb-5">{l s='Fecha de vencimiento' mod='mercadopago'} <em class="mp-required">*</em></label>
                    <input id="id-card-expiration" data-checkout="cardExpiration" type="text" class="form-control mp-form-control" autocomplete="off" placeholder="MM/AAAA" onkeyup="maskInput(this, mdate);" maxlength="7" />
                    <small id="id-card-expiration-status" class="mp-erro-form"></small>
                </div>

                <div class="col-md-6 col-6 pb-20 pr-0 mp-m-col">
                    <label for="id-security-code" class="pb-5">{l s='Código de seguridad' mod='mercadopago'} <em class="mp-required">*</em></label>
                    <input id="id-security-code" data-checkout="securityCode" type="text" class="form-control mp-form-control" autocomplete="off" placeholder="{l s='CVV' mod='mercadopago'}" onkeyup="maskInput(this, minteger);" maxlength="4" />
                    <small class="mp-small pt-5">{l s='Últimos 3 números del dorso' mod='mercadopago'}</small>
                    <small id="id-security-code-status" class="mp-erro-form pt-0"></small>
                </div>
            </div>

            <div class="col-md-12 col-12 frame-title">
                <h3 class="title-custom-checkout">{l s='Cuántas cuotas querés pagar' mod='mercadopago'}</h3>
            </div>

            <div class="form-group">
                <div id="container-issuers" class="issuers-options col-md-4 col-4 pb-20 pl-0 mp-m-col">
                    <label for="id-issuers-options" class="issuers-options pb-5">{l s='Banco emisor' mod='mercadopago'}</label>
                    <select class="issuers-options form-control mp-form-control mp-select pointer" id="id-issuers-options" data-checkout="issuer" name="mercadopago_custom[issuer]" type="text"></select>
                    <small id="id-issuer-status" class="mp-erro-form"></small>
                </div>

                <div id="container-installments" class="col-md-8 col-8 pb-20 pr-0 mp-m-col">
                    <label for="id-installments" class="pb-5">{l s='Seleccione el número de cotas' mod='mercadopago'}</label>
                    <select class="form-control mp-form-control mp-select pointer" id="id-installments" data-checkout="installments" name="mercadopago_custom[installments]" type="text"></select>
                    <small id="id-installments-status" class="mp-erro-form"></small>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="mp-text-cft"></div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="mp-text-tea"></div>
                        </div>
                    </div>
                </div>
            </div>

            {if $site_id != 'MLM'}
            <div class="col-md-12 col-12 frame-title">
                <h3 class="title-custom-checkout">{l s='Ingresá tu número de documento' mod='mercadopago'}</h3>
            </div>

            <div class="form-group">
                <div class="col-md-4 col-4 pb-20 pl-0 mp-m-col">
                    <label for="id-docType" class="pb-5">{l s='Tipo' mod='mercadopago'}</label>
                    <select id="id-docType" data-checkout="docType" class="form-control mp-form-control mp-select pointer"></select>
                </div>

                <div class="col-md-8 col-8 pb-20 pr-0 mp-m-col">
                    <label for="id-doc-number" class="pb-5">{l s='Número de documento' mod='mercadopago'}</label>
                    <input id="id-doc-number" data-checkout="docNumber" type="text" class="form-control mp-form-control" onkeyup="maskInput(this, minteger);" autocomplete="off" />
                    <small class="mp-small pt-5">{l s='Solo números' mod='mercadopago'}</small>
                    <small id="id-doc-number-status" class="mp-erro-form pt-0"></small>
                </div>
            </div>
            {/if}

            <div class="col-md-12 col-xs-12 col-12 px-0 mp-m-col">
                <p class="all-required"><em class="mp-required text-bold">*</em> {l s='Campo obligatorio' mod='mercadopago'}</p>
            </div>
        </div>

        <div id="mercadopago-utilities">
            <input type="hidden" id="amount" value="{$amount|escape:'htmlall':'UTF-8'}" />
            <input type="hidden" id="card_token_id" name="mercadopago_custom[card_token_id]" />
            <input type="hidden" id="payment_type_id" name="mercadopago_custom[payment_type_id]" />
            <input type="hidden" id="payment_method_id" name="mercadopago_custom[payment_method_id]" />
            <input type="hidden" id="campaignIdCustom" name="mercadopago_custom[campaign_id]" />
            <input type="hidden" id="couponPercentCustom" name="mercadopago_custom[percent_off]" />
            <input type="hidden" id="couponAmountCustom" name="mercadopago_custom[coupon_amount]" />
        </div>

    </div>
</form>

<script type="text/javascript" src="{$module_dir|escape:'htmlall':'UTF-8'}/views/js/jquery-1.11.0.min.js"></script>

{if $public_key != ''}
<script type="text/javascript">
    if (window.Mercadopago === undefined) {
        $.getScript("https://secure.mlstatic.com/sdk/javascript/v1/mercadopago.js").done(function (script, textStatus) {
            Mercadopago.setPublishableKey("{$public_key|escape:'javascript':'UTF-8'}");
        });
    }
</script>
{/if}

<script type="text/javascript">
    $("#id-card-number").val("");

    //collapsible payments
    var show_payments = document.querySelector("#button-show-payments");
    var frame_payments = document.querySelector("#frame-payments");

    show_payments.onclick = function () {
        if (frame_payments.style.display == "block") {
            frame_payments.style.display = "none";
        } else {
            frame_payments.style.display = "block";
        }
    };

    var cardBefore = "";
    var site_id = "{$site_id|escape:'javascript':'UTF-8'}";

    // load issuers for Mexico and Peru
    if (site_id === "MLM" || site_id === "MPE") {
        var options_credit;
        var options_debit;
        var option = new Option("{l s='Choose...' mod='mercadopago'}", "", true, true);
        $("#credit_option").append(option);
        "{if count($credit) != 0}"
        "{foreach $credit as $tarjeta}"
        options_credit = new Option("{$tarjeta['name']|escape:'htmlall':'UTF-8'} {l s='Credit' mod='mercadopago'}", "{$tarjeta['id']|lower|escape:'htmlall':'UTF-8'}");
        $("#credit_option").append(options_credit);
        options_credit.setAttribute("payment_type_id", "{$tarjeta['type']|escape:'htmlall':'UTF-8'}");
        "{/foreach}"
        "{/if}"

        "{if count($debit) != 0}"
        "{foreach $debit as $tarjeta}"
        options_debit = new Option("{$tarjeta['name']|escape:'htmlall':'UTF-8'}", "{$tarjeta['id']|lower|escape:'htmlall':'UTF-8'}");
        $("#credit_option").append(options_debit);
        options_debit.setAttribute("payment_type_id", "{$tarjeta['type']|escape:'htmlall':'UTF-8'}");
        "{/foreach}"
        "{/if}"
    }

    $("input[data-checkout='cardNumber'], input[name='card-types']").bind("change", function () {
        loadCard();
    });

    function loadCard() {
        if ($("#id-card-number").val() == cardBefore) {
            return;
        }

        cardBefore = $("#id-card-number").val();

        //limpa o cupom
        //removerCoupon();
        //limpa validação
        $("#id-card-number-status").html("");
        $("#id-card-number").removeClass("form-error");

        var bin = getBin();
        if (bin.length == 6) {
            var json = {}
            json.bin = bin;
            Mercadopago.getPaymentMethod(json, setPaymentMethodInfo);
            if (site_id != "MLM") {
                Mercadopago.getIdentificationTypes();
            }
        }
        else if (bin.length < 6) {
            $("#id-card-number").css('background-image', '');
            $("#id-installments").html('');
            if (site_id == "MLM" || site_id == "MPE") {
                $("#id-issuers-options").html('');
            }
        }
    }

    function getBin() {
        var card = $("#id-card-number").val().replace(/ /g, '').replace(/-/g,
            '').replace(/\./g, '');
        var bin = card.substr(0, 6);
        return bin;
    }

    function returnAmount() {
        if ($("#amount_discount").text() != "") {
            return $("#total_amount_discount").text();
        } else {
            return $("#amount").val();
        }
    }

    // Estabeleça a informação do meio de pagamento obtido
    function setPaymentMethodInfo(status, result) {
        if ($("#id-issuers-options option") != undefined) {
            $("#id-issuers-options option").remove();
        }

        if (status != 404 && status != 400 && result != undefined) {
            //adiciona a imagem do meio de pagamento
            var payment_method = result[0];
            var amount = returnAmount();
            var bin = getBin();
            if (site_id === "MLM" || site_id === "MLA" || site_id === "MPE" || site_id === 'MLU') {
                // check if the issuer is necessary to pay
                var issuerMandatory = false,
                    additionalInfo = result[0].additional_info_needed;

                for (var i = 0; i < additionalInfo.length; i++) {
                    if (additionalInfo[i] == "issuer_id") {
                        issuerMandatory = true;
                    }
                }

                if (issuerMandatory) {
                    var payment_method_issue = 0;

                    if (site_id === "MLM" || site_id === "MPE") {
                        payment_method_issue = document.getElementById("credit_option").value;
                    } else {
                        payment_method_issue = result[0].id;
                    }
                    Mercadopago.getIssuers(payment_method_issue, showCardIssuers);
                }
            }
            if (document.querySelector("#id-issuers-options").options.length == 0) {
                document.querySelector("#id-issuers-options").style.display = 'none';
                document.querySelector(".issuers-options").style.display = 'none';
                $("#container-installments").removeClass('col-md-8');
                $("#container-installments").addClass('col-md-12, pl-0');
            }


            $("#id-card-number").css("background", "url(" + payment_method.secure_thumbnail + ") 98% 50% no-repeat");
            $("#payment_method_id").val(payment_method.id);
            $("#payment_type_id").val(payment_method.payment_type_id);

            loadInstallments();

        } else {
            $("#id-card-number").css('background-image', '');
            $("#id-installments").html('');
        }
    }


    $("#credit_option").change(function (e) {
        $("#id-card-number").val("");
        loadCard();
    });

    function loadInstallments() {
        //load Installment
        var bin = getBin();
        var json = {}
        json.amount = returnAmount();
        json.bin = bin;

        if (site_id === "MLM" || site_id === "MLA" || site_id === "MLU") {
            var issuerId = document.querySelector('#id-issuers-options').value;
            if (issuerId != undefined && issuerId != "-1") {
                json.issuer_id = issuerId;
            }
        }
        try {
            Mercadopago.getInstallments(json, setInstallmentInfo);
        } catch (e) {
            console.info(e);
        }
    }

    function returnAmount() {
        return $("#amount").val();
    }

    //Mostre as parcelas disponíveis no div 'installmentsOption'
    function setInstallmentInfo(status, installments) {
        if ($("#id-installments option") != undefined) {
            $("#id-installments option").remove();
        }

        if (status != 404 && status != 400 && installments.length > 0) {
            var options = new Option("{l s='Choose...' mod='mercadopago'}", "", true, true);
            $("#id-installments").append(options);
            var installments = installments[0].payer_costs;
            $.each(installments, function (key, value) {
                options = new Option(value.recommended_message, value.installments);
                // tax resolution 51/2017 arg
                var dataInput = "";
                var tax = value.labels;
                if (tax.length > 0) {
                    for (var l = 0; l < tax.length; l++) {
                        if (tax[l].indexOf('CFT_') !== -1) {
                            dataInput = tax[l]
                        }
                    }
                }
                options.setAttribute("data-tax", dataInput);
                $("#id-installments").append(options);

            });
        } else {
            console.error("Installments Not Found.");
        }
        taxesInstallments();
    }

    function taxesInstallments() {
        var selectorInstallments = document.querySelector("#id-installments");
        showTaxes(selectorInstallments);
    }

    function showTaxes(selectorInstallments) {
        var tax = null;

        if (selectorInstallments.selectedIndex > -1) {
            tax = selectorInstallments.options[selectorInstallments.selectedIndex].getAttribute('data-tax');
        }

        var cft = "";
        var tea = "";

        if (tax != null) {
            var tax_split = tax.split('|');
            cft = tax_split[0].replace('_', ' ');
            tea = tax_split[1].replace('_', ' ');

            if (cft == "CFT 0,00%" && tea == "TEA 0,00%") {
                cft = "";
                tea = "";
            }

        }

        $(".mp-text-cft").html(cft);
        $(".mp-text-tea").html(tea);
    }

    function clearErrorStatus() {
        $("#id-card-number-status").html("");
        $("#id-security-code-status").html("");
        $("#id-card-expiration-status").html("");
        $("#id-card-holder-name-status").html("");
        $("#id-doc-number-status").html("");
        $("#id-installments-status").html("");

        $("#id-card-number").removeClass("mp-erro-input");
        $("#id-security-code").removeClass("mp-erro-input");
        $("#id-card-expiration").removeClass("mp-erro-input");
        $("#id-card-holder-name").removeClass("mp-erro-input");
        $("#id-doc-number").removeClass("mp-erro-input");
        $("#id-installments").removeClass("mp-erro-input");
        $("#id-docType").removeClass("mp-erro-input");
    }

    function validate() {
        if ($("#id-card-number").val().length == 0) {
            $("#id-card-number-status").html("{l s='Invalid card number' mod='mercadopago'}");
            $("#id-card-number").addClass("mp-erro-input");
        }

        if ($("#id-card-holder-name").val().length == 0) {
            $("#id-card-holder-name-status").html("{l s='Invalid card holder name' mod='mercadopago'}");
            $("#id-card-holder-name").addClass("mp-erro-input");
        }

        if ($("#id-security-code").val().length == 0) {
            $("#id-security-code-status").html("{l s='Invalid security code' mod='mercadopago'}");
            $("#id-security-code").addClass("mp-erro-input");
        }

        if ($("#id-docType").val() == null || $("#id-docType").val() == "") {
            $("#id-docType").addClass("mp-erro-input");
        }

        if ($("#id-installments").val() == null || $("#id-installments").val().length == 0) {
            $("#id-installments-status").html("{l s='You must select a installment' mod='mercadopago'}");
            $("#id-installments").addClass("mp-erro-input");
        }

        if ($("#id-issuers-options").val() == null || $("#id-issuers-options").val() == -1 || $("#id-issuers-options").val().length == 0) {
            $("#id-issuer-status").html("{l s='You must select a issuer' mod='mercadopago'}");
            $("#id-issuers-options").addClass("mp-erro-input");
        }

        if (site_id != "MLM") {
            if ($("#id-doc-number").val().length == 0) {
                $("#id-doc-number-status").html("{l s='Invalid document number' mod='mercadopago'}");
                $("#id-doc-number").addClass("mp-erro-input");
            }
        }

        if ($("#id-installments").val() == null
            || $("#id-installments").val().length == 0
            || $("#id-security-code").val().length == 0 || $("#id-card-holder-name").val().length == 0
            || $("#id-card-number").val().length == 0
            || (site_id != "MLM" && $("#id-doc-number").val().length == 0)) {
            if (document.getElementById('conditions_to_approve[terms-and-conditions]') != undefined) {
                document.getElementById('conditions_to_approve[terms-and-conditions]').checked = false;
            }
            return false;
        }

        if (site_id == "MLB") {
            if (!validateCpf($("#id-doc-number").val())) {
                $("#id-doc-number-status").html("{l s='Invalid document number' mod='mercadopago'}");
                $("#id-doc-number").addClass("mp-erro-input");
                if (document.getElementById('conditions_to_approve[terms-and-conditions]') != undefined) {
                    document.getElementById('conditions_to_approve[terms-and-conditions]').checked = false;
                }
                return false;
            }
        }

        return true;
    }

    function validateCpf(cpf) {
        var soma;
        var resto;
        soma = 0;
        if (cpf == "00000000000")
            return false;

        for (i = 1; i <= 9; i++) {
            soma = soma + parseInt(cpf.substring(i - 1, i)) * (11 - i);
            resto = (soma * 10) % 11;
        }

        if ((resto == 10) || (resto == 11))
            resto = 0;

        if (resto != parseInt(cpf.substring(9, 10)))
            return false;

        soma = 0;

        for (i = 1; i <= 10; i++) {
            soma = soma + parseInt(cpf.substring(i - 1, i)) * (12 - i);
            resto = (soma * 10) % 11;
        }

        if ((resto == 10) || (resto == 11))
            resto = 0;

        if (resto != parseInt(cpf.substring(10, 11))) {
            return false;
        } else {
            return true;
        }
    }

    function getPaymentMethods() {
        var json = {};

        if (site_id == "MLM" || site_id == "MPE") {
            var credit_option = document.querySelector('#credit_option');
            console.info(credit_option[credit_option.options.selectedIndex]);
            console.info(credit_option);
            console.info("credit====" + credit_option[credit_option.options.selectedIndex].getAttribute('value'));
            json.payment_method_id = credit_option[credit_option.options.selectedIndex].getAttribute('value');

            var payment_type_id = credit_option[credit_option.options.selectedIndex].getAttribute('payment_type_id');
            console.info("payment===" + payment_type_id);
            json.payment_type_id = payment_type_id;

        } else {
            json.payment_method_id = $("#payment_method_id").val();
            json.payment_type_id = $("#payment_type_id").val();
        }

        console.info("json paymentMethod" + json);

        return json;
    }

    function tokenResponseHandler(status, response) {
        var $form = $('#mp_custom_checkout');
        if (response.error) {
            if (document.getElementById('conditions_to_approve[terms-and-conditions]') != undefined) {
                document.getElementById('conditions_to_approve[terms-and-conditions]').checked = false;
            }
            $.each(response.cause, function (p, e) {
                switch (e.code) {
                    case "E301":
                        $("#id-card-number-status").html("{l s='Invalid card number' mod='mercadopago'}");
                        $("#id-card-number").addClass("mp-erro-input");
                        break;
                    case "E302":
                        $("#id-security-code-status").html("{l s='Invalid security code' mod='mercadopago'}");
                        $("#id-security-code").addClass("mp-erro-input");
                        break;
                    case "325":
                    case "326":
                        $("#id-card-expiration-status").html("{l s='Invalid card expiration date' mod='mercadopago'}");
                        $("#id-card-expiration").addClass("mp-erro-input");
                        break;
                    case "316":
                    case "221":
                        $("#id-card-holder-name-status").html("{l s='Invalid card holder name' mod='mercadopago'}");
                        $("#id-card-holder-name").addClass("mp-erro-input");
                        break;
                    case "324":
                    case "214":
                        $("#id-doc-number-status").html("{l s='Invalid document number' mod='mercadopago'}");
                        $("#id-doc-number").addClass("mp-erro-input");
                        break;
                }
            });
        } else {
            var card_token_id = response.id;
            var jsonPaymentMethod = getPaymentMethods();
            var cardNumber = $("#id-card-number").val();
            var lastFourDigits = cardNumber.substring(cardNumber.length - 4);
            document.getElementById("payment_type_id").value = jsonPaymentMethod.payment_type_id;
            document.getElementById("payment_method_id").value = jsonPaymentMethod.payment_method_id;
            document.getElementById("card_token_id").value = card_token_id;
            document.forms['mp_custom_checkout'].submit();
        }
    }

    document.forms['mp_custom_checkout'].onsubmit = function () {
        clearErrorStatus();
        if (validate()) {
            var $form = $('#mp_custom_checkout');
            Mercadopago.createToken($form, tokenResponseHandler);
        }

        return false;
    }


    function showCardIssuers(status, issuers) {
        var issuersSelector = null;
        var id_issuers_options = null;
        var issuers_options = null;
        var container_issuers = null;
        var container_installments = null;
        var opcaoPagamento = $("#opcaoPagamentoCreditCard").val();

        issuersSelector = document.querySelector("#id-issuers-options"), fragment = document.createDocumentFragment();
        id_issuers_options = document.querySelector("#id-issuers-options");
        issuers_options = document.querySelector(".issuers-options");
        container_issuers = document.querySelector("#container-issuers");

        if (issuers.length > 0) {
            issuersSelector.options.length = 0;
            var option = new Option("{l s='Choose' mod='mercadopago'}...", '-1');
            fragment.appendChild(option);
            for (var i = 0; i < issuers.length; i++) {
                if (issuers[i].name != "default") {
                    option = new Option(issuers[i].name, issuers[i].id);
                } else {
                    option = new Option("Otro", issuers[i].id);
                }
                fragment.appendChild(option);
            }

            issuersSelector.appendChild(fragment);
            issuersSelector.removeAttribute('disabled');

            $("#container-installments").removeClass('col-md-12, pl-0');
            $("#container-installments").addClass('col-md-8');

            id_issuers_options.removeAttribute('style');
            issuers_options.removeAttribute('style');
        }
    }

    if (site_id === "MLM" || site_id === "MLA" || site_id === "MPE" || site_id === "MLU") {
        $("#id-issuers-options").change(function () {

            var issuerId = $('#id-issuers-options').val();
            var amount = returnAmount();

            Mercadopago.getInstallments({
                "bin": getBin(),
                "amount": amount,
                "issuer_id": issuerId
            }, setInstallmentInfo);

        });
    }

    if (site_id === "MLA") {
        $("#id-installments").change(taxesInstallments);
        $(".mp-text-cft").show();
        $(".mp-text-tea").show();
    }

    //apply coupon
    var MPv1Custom = {
        params: {
            coupon_url: "",
        },
        coupon: {
            couponCode: "#couponCodeCustom",
            couponError: "#mpCouponErrorCustom",
            couponSending: "#mpSendingCouponCustom",
            couponSuccess: "#mpCouponApplyedCustom",
            responseError: "#mpResponseErrorCustom",
            inputCampaignId: "#campaignIdCustom",
            inputCouponAmount: "#couponAmountCustom",
            inputCouponPercent: "#couponPercentCustom",
            buttonApplyCoupon: "#applyCouponCustom",
        },
    }

    var coupon_url = '{$coupon_url}';
    mpValidateParams(coupon_url);

    //validate params
    function mpValidateParams(coupon_url) {
        MPv1Custom.params.coupon_url = coupon_url.replace(/&amp;/g, "&");
        console.log(MPv1Custom.params.coupon_url);
    }

    //ajax coupon
    function mpCustomApplyAjax() {
        var couponCode = document.querySelector(MPv1Custom.coupon.couponCode);
        var couponError = document.querySelector(MPv1Custom.coupon.couponError);
        var couponSuccess = document.querySelector(MPv1Custom.coupon.couponSuccess);
        var couponSending = document.querySelector(MPv1Custom.coupon.couponSending);
        var responseError = document.querySelector(MPv1Custom.coupon.responseError);
        var inputCampaignId = document.querySelector(MPv1Custom.coupon.inputCampaignId);
        var inputCouponAmount = document.querySelector(MPv1Custom.coupon.inputCouponAmount);
        var inputCouponPercent = document.querySelector(MPv1Custom.coupon.inputCouponPercent);
        var buttonApplyCoupon = document.querySelector(MPv1Custom.coupon.buttonApplyCoupon);

        $.ajax({
            url: MPv1Custom.params.coupon_url,
            type: 'POST',
            data: {
                coupon: couponCode.value,
            },
            beforeSend: function () {
                couponError.style.display = "none";
                couponSuccess.style.display = "none";
                couponSending.style.display = "block";
            },
            success: function (success) {
                console.log(success);
                couponSending.style.display = "none";
                responseError.style.display = "none";

                if (success.code > 202) {
                    couponError.style.display = "block";
                    couponSuccess.style.display = "none";
                }
                else {
                    couponError.style.display = "none";
                    couponSuccess.style.display = "block";
                    couponCode.readOnly = true;
                    buttonApplyCoupon.disabled = true;
                    couponCode.style.cssText = 'background-color:#f8f8f8 !important';
                    inputCampaignId.value = success.message.id;
                    inputCouponAmount.value = success.message.coupon_amount;
                    inputCouponPercent.value = success.message.percent_off;
                }
            },
            error: function (error) {
                console.log(error);
                couponError.style.display = "none";
                ouponSending.style.display = "none";
                couponSuccess.style.display = "none";
                responseError.style.display = "block";
            }
        });
    }

</script>