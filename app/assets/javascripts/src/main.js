$(function() {

	/**
	 * TODO: Use a more flexible structure like jQuery plugins and/or a system like Webpack or requireJS
	 */
	
	/**
	 * Bugfix cycle-pager
	 */
	$('.cycle-slideshow').on('cycle-update-view', function() {
		var sentinel = $('.cycle-sentinel');
		if (sentinel.attr('src') != sentinel.attr('data-original')) {
			sentinel.attr('src', sentinel.attr('data-original'));
		}
	});

	if (location.href = 'http://vps344707.ovh.net/en/donate') {
		console.log('Capistrano test has passed successfully !');
	}

	/**
	 * Mobile menu
	 */
	var $menuButton = $('#menu-btn'),
		$nav = $('nav'),
		$menu = $nav.find('ul.menu');

	$menuButton.magnificPopup({
		items: {
			src: $menu,
			type: 'inline'
		},
		mainClass: 'my-mfp-slide-bottom mobile-menu-wrapper',
		removalDelay: 300,

		fixedContentPos: true,
		fixedBgPos: true,
		alignTop: true,

		overflowY: 'auto',

		closeBtnInside: false,
		showCloseBtn: true,
		preloader: true
	});


	/**
	 * Sticky menu
	 */
	var $header = $('#header');

	$(window).on('scroll', function() {
		var $bodyHTML = $('body');

		// For Firefox and IE
		if (navigator.userAgent.indexOf('Firefox') > 0 ||
			navigator.userAgent.indexOf('MSIE') > 0) {
			$bodyHTML = $('html');
		}

		var navHeight = $nav.height(),
			stickIt = function() {
				$header.css('margin-bottom', navHeight);
				$nav.addClass('sticky');
			};

		if ($bodyHTML.scrollTop() >= 250 &&
			$(window).width() >= 1200
		) {
			stickIt();
		}
		else if ($bodyHTML.scrollTop() >= 200 &&
			$(window).width() >= 1024 &&
			$(window).width() < 1200
		) {
			stickIt();
		}
		else if ($bodyHTML.scrollTop() >= 160 &&
			$(window).width() < 1024
		) {
			stickIt();
		}
		else {
			$header.css('margin-bottom', 0);
			$nav.removeClass('sticky');
		}
	});


	/**
	 * Same height boxes
	 */
	var $donateBoxes = $('#donate').find('.col-wrapper.transfer'),
		$firstBox = $donateBoxes.find('.first .text-content'),
		$secondBox = $donateBoxes.find('.second .text-content'),
		$paypalWrapper = $donateBoxes.find('.paypal-wrapper');

	var applySameHeight = function() {
		if ($(window).width() >= 768) {
			$secondBox.css('height', $firstBox.height());

			var secondBoxHeight = $secondBox.height(),
				paypalWrapperHeight = $paypalWrapper.height(),
				paypalWrapperPadding = (secondBoxHeight - paypalWrapperHeight) / 2;

			$paypalWrapper.css({
				paddingTop: paypalWrapperPadding,
				paddingBottom: paypalWrapperPadding
			})
		}
		else {
			$secondBox.removeAttr('style');
		}
	};

	$(window).on('resize', function() {
		applySameHeight();
	});

	applySameHeight();


	/**
	 * Helps the visitor to know the requirements of each choices because PayPal has some currencies and payments
	 * methods restrictions
	 * @desc This module chooses between showing tooltips or popups to the visitor depending of the device he's using
	 * to enhance the user experience.
	 * @type {{init, tooltips, popup}}
	 */
	var payPalHelper = function() {
		var $donateButton = $('.donate-button');

		return {
			/**
			 * Initialization function of the module
			 */
			init: function() {
				if (Modernizr.touchevents) {
					// Popup is better for touch devices
					payPalHelper.popup();
				}
				else {
					// Tooltips are more discrete for mouse-driven devices
					payPalHelper.tooltips();
				}
			},

			/**
			 * Initialization and configuration for the tooltips
			 */
			tooltips: function() {
				$donateButton.each(function() {
					$(this).qtip({
						content: {
							text: $(this).data('tip')
						},
						position: {
							target: $(this),
							my: 'left center',
							at: 'right center'
						}
					});
				});
			},

			/**
			 * Popup function
			 */
			popup: function() {
				var $infoTip = $('#chf-button, #other-currencies'),
					message,
					id;

				// Initialization and configuration for the popup
				$infoTip.magnificPopup({
					items: {
						type: 'inline',
						src: '.info-tip'
					},
					mainClass: 'my-mfp-slide-bottom',
					removalDelay: 300,
					midClick: true,
					fixedContentPos: true,
					fixedBgPos: true,
					overflowY: 'auto',
					closeBtnInside: true,
					preloader: false
				});

				// Dynamic data recovery for the popup
				// TODO: Enhance the code for a generic use
				$donateButton.on('click', function(ev) {
					ev.preventDefault();

					var $infoTipOk = $('.info-tip-ok');
					message = $(this).data('tip');
					id = $(this).attr('id');

					// Setting the right message in the popup
					$('.info-tip-message').text(message);

					// Setting the right trigger to the accept button of the popup
					$infoTipOk.off('click');

					// If clicked on the Swiss francs button
					if (id == 'chf-button') {
						$infoTipOk.removeAttr('href');
						$infoTipOk.on('click', function() {
							$('#cindy-paypal-btn').trigger('submit');
						});
					}

					// If clicked on Other currencies button
					else if (id == 'other-currencies') {
						var link = $('#other-currencies').attr('href');
						$infoTipOk.attr('href', link);
					}

					// Closing the popup on any button click
					$('.info-tip-button').on('click', function() {
						$(this).parent().find('.mfp-close').trigger('click');
					});
				});
			}
		}
	}();

	// Initiates the module
	payPalHelper.init();

	
	/**
	 * Landscape detection
	 */
	var $main = $('#main');

	var orientationDetection = function() {
		if (window.innerWidth > window.innerHeight) {
			if (!$main.hasClass('landscape')) {
				$main.addClass('landscape');
			}
			if ($main.hasClass('portrait')) {
				$main.removeClass('portrait');
			}
		}
		else {
			if (!$main.hasClass('portrait')) {
				$main.addClass('portrait');
			}
			if ($main.hasClass('landscape')) {
				$main.removeClass('landscape');
			}
		}
	};

	$(window).on('orientationchange', function() {
		orientationDetection();
	});

	orientationDetection();


	/**
	 * Lazyload for images
	 */
	var $lazyLoadedImages = $('.lazy');

	$lazyLoadedImages.lazyload({
		effect: "fadeIn",
		threshold: 720
	});


	/**
	 * MediaelementJS Player initialization
	 */
	$('audio').mediaelementplayer();


	/**
	 * Contact form
	 */
	$('#invite-btn').magnificPopup({
		items: {
			src: '.invite-form',
			type: 'inline'
		},

		mainClass: 'my-mfp-slide-bottom',
		removalDelay: 300,
		midClick: true,

		fixedContentPos: true,
		fixedBgPos: true,

		overflowY: 'auto',

		closeBtnInside: true,
		preloader: true
	});

	// Validation labels
	var lang = location.href,
		inviteUrl = "/fr/invites",
		inviteError = "Une erreur est survenue. Veuillez vérifier tous les champs.",
		inviteEmptyField = "Veuillez contrôler que vous avez rempli tous les champs correctement";

	if (lang.indexOf('/en') > 0) {
		inviteUrl = "/en/invites";
		inviteError = "An error occurred. Please verify all the fields.";
		inviteEmptyField = "Please check that you filled all the fields correctly";
	}

	$('#invite-submit').on('click', function(event) {
		event.preventDefault();

		var $inviteError = $('#invite-error'),
			$inviteMessage = $('#invite-message'),
			$formFields = $('#new_invite').find('[required]');

		// Client-side form validation
		var $emailValidationField = $('#email-validation'),
			$email = $('#email-field'),
			emailValidationUrl = "https://api.mailgun.net/v3/address/validate?api_key=pubkey-135843064e02dcc8c474620672e4f93e&address=" + $email.val();

		$.ajax({
			method: "GET",
			url: emailValidationUrl,
			dataType: "jsonp",
			success: function(data) {
				$.when(
					$emailValidationField.val(data.is_valid)
				).then(
					checkFields() ? sendForm() : requireData()
				);
			},
			error: function(response, statusText, serverText) {
				$inviteError.text(inviteError);
				$inviteError.addClass('active');

				console.log(
					{
						HTTP_code: statusText,
						HTTP_text: serverText
					}
				);
			}
		});

		var checkFields = function() {

			check();

			$formFields.on('click keyup', function() {
				check();
			});

			function check() {
				$formFields.each(function() {
					var $field = $(this).not($email);

					if ($field.val() == '' || $field.val() == $field.attr('placeholder')) {
						$field.css('background-color', '#FFE8E8');
						$field.attr('data-invalid', true);
					}
					else {
						$field.css('background-color', '#E8FFE8');
						$field.removeAttr('data-invalid');
					}
				});

				if ($email.val() == '' || $emailValidationField.val() == 'false') {
					$email.css('background-color', '#FFE8E8');
				}
				else {
					$email.css('background-color', '#E8FFE8');
				}
			}

			if ($('#new_invite').find('[data-invalid]').length == 0) {
				return true;
			}
		};

		var requireData = function() {
			$inviteError.text(inviteEmptyField);
			$inviteError.addClass('active');
		};

		// Form submitting
		var sendForm = function() {

			$.ajax({
				method: "post",
				url: inviteUrl,
				data: $('#new_invite').serialize(),
				success: function(data, statusText, response) {
					var status = response.responseJSON.status,
						statusMessage = response.responseJSON.statusMessage;

					if (status) {
						$('#new_invite').hide();
						$inviteMessage.text(statusMessage);
						$inviteMessage.addClass('active');
					}
					else {
						$inviteError.text(statusMessage);
						$inviteError.addClass('active');
					}

					console.log(response.responseJSON)
				},
				error: function(response, statusText, serverText) {
					$inviteError.text(inviteError);
					$inviteError.addClass('active');

					console.log(
						{
							HTTP_code: statusText,
							HTTP_text: serverText
						}
					);
				}
			});

		};

	});
	

	// Form submitting
	$('#chf-btn').on('click', function(event) {
		event.preventDefault();
		document.createElement('form').submit.apply(this.form);
	});

	
	/**
	 * IE 9 Placeholder polyfill
	 */
	if (navigator.userAgent.indexOf('MSIE 9.0') > 0) {
		$('[placeholder]').each(function() {
			var $field = $(this),
				value = $field.attr('placeholder');

			$field.val(value).css('color', '#666666');

			$field
				.on('focus', function() {
					if ($(this).val() == value) {
						$(this).val('').css('color', '#000000');
					}
				})
				.on('blur', function() {
					if ($(this).val() == '') {
						$(this).val(value).css('color', '#666666');
					}
				})
		})
	}
	
});


// Load the IFrame Player API code asynchronously.
var ytTag = document.createElement('script');
var state = false;
ytTag.setAttribute('data-src', "https://www.youtube.com/player_api");
ytTag.defer = 'defer';
var firstScriptTag = document.getElementsByTagName('script')[0];
ytTag.async = 'async';
firstScriptTag.parentNode.insertBefore(ytTag, firstScriptTag);


document.addEventListener('DOMContentLoaded', function() {
	ytTag.setAttribute('src', ytTag.getAttribute('data-src'));
	state = true;
});

document.onreadystatechange = function() {
	if (state && document.readyState == 'complete') {

		// Load the Universal Analytics code asynchronously.
		var gaTag = document.createElement('script');
		gaTag.src = "https://www.google-analytics.com/analytics.js";
		gaTag.async = 'async';
		firstScriptTag.parentNode.insertBefore(gaTag, firstScriptTag);

		// Load the reCAPTCHA code asynchronously.
		var recaptchaTag = document.createElement('script');
		recaptchaTag.src = "https://www.google.com/recaptcha/api.js";
		recaptchaTag.async = 'async';
		firstScriptTag.parentNode.insertBefore(recaptchaTag, firstScriptTag);

		// Sends a pageview signal to Universal Analytics
		if (window.location.hostname != 'cindy.io' && window.location.hostname != 'localhost') {
			window.ga = window.ga || function() {(ga.q = ga.q || []).push(arguments)};
			ga.l = +new Date;
			ga('create', 'UA-66662722-1', 'auto');
			ga('send', 'pageview');
		}

		// Replace the 'ytplayer' element with an <iframe> and
		// YouTube player when the video element become visible.
		var player,
			windowHeight = window.innerHeight,
			ytPlayerElement = document.getElementById('footer-video-player'),
			ytElementTopPos,
			ytPlayerEvent;

		ytPlayerEvent = window.addEventListener('scroll', function() {
			ytElementTopPos = ytPlayerElement.getBoundingClientRect().top;

			if (ytElementTopPos < windowHeight) {
				player = new YT.Player('footer-video-player', {
					width: '371',
					height: '209', // Min: 200x200
					videoId: '2-QJYS9Vg7c',
					fs: 1,
					autohide: 1
				});
				ytPlayerElement.removeEventListener('scroll', ytPlayerEvent);
			}
		})

		/** Lazyload for iframe
		 *
		 *	var vidDefer = document.getElementsByTagName('iframe');
		 *	for (var i = 0; i < vidDefer.length; i++) {
		 *		if (vidDefer[i].getAttribute('data-src')) {
		 *			vidDefer[i].setAttribute('src', vidDefer[i].getAttribute('data-src'));
		 *		}
		 *	}
	     */

		
		var $youtubeVideoWrap = $('.youtube-video-wrap'),
			$vimeoVideoWrap = $('.vimeo-video-wrap'),
			youtubeUrl = 'https://www.youtube.com/embed/',
			vimeoUrl = 'https://player.vimeo.com/video/',
			youtubeParams = '?autoplay=1&autohide=1',
			vimeoParams = '?autoplay=1';
		
		/**
		 * Loads YouTube and Vimeo iframes smartly for a fast page load
		 * @param type Type of the video | YouTube or Vimeo
		 * @param $element Wrapper
		 * @param url Embed url
		 * @param params Custom params
		 */
		function smartVideoLoader(type, $element, url, params) {
			var cover,
				iframeUrl,
				iframe;

			$element.each(function() {
				// Set the BG image from the video ID
				if (type == 'YouTube') {
					cover = 'https://i.ytimg.com/vi/' + this.id + '/hqdefault.jpg';
				}
				else if (type == 'Vimeo') {
					cover = $(this).data('img-url');
				}
				else {
					return console.warn('You must set "Youtube" or "Vimeo" for the "type" parameter');
				}

				$(this).css('background-image', 'url(' + cover + ')');

				// Click the video div
				$(document).on('click', '#'.concat(this.id), function() {
					// Build embed URL
					iframeUrl = url + this.id + params;
					// Grab extra parameters set on div
					if ($(this).data('params')) iframeUrl += '&' + $(this).data('params');
					// Build iframe tag
					iframe = $('<iframe/>', {
						'allowfullscreen': 'allowfullscreen',
						'frameborder': '0',
						'src': iframeUrl
					});
					// Replace the video thumbnail with YouTube or Vimeo HTML5 Player
					$(this).append(iframe);
				});
			});
		}

		smartVideoLoader('YouTube', $youtubeVideoWrap, youtubeUrl, youtubeParams);
		smartVideoLoader('Vimeo', $vimeoVideoWrap, vimeoUrl, vimeoParams);

	}
}
