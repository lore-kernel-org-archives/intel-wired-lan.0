From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 12 Jun 2019 14:57:12 -0300
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add control of skipping PF
 link-status check
In-Reply-To: <CAHD1Q_zp_F0CMp-Z72R774-tPm3Vs+96m5DvKtmZbCTz6wAVjA@mail.gmail.com>
References: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F265@FMSMSX110.amr.corp.intel.com>
 <CAHD1Q_zp_F0CMp-Z72R774-tPm3Vs+96m5DvKtmZbCTz6wAVjA@mail.gmail.com>
Message-ID: <CAHD1Q_zP2fiVmbL4gkubWO-AaU6n0CgR81RfihhhTjB4wTyKVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Oh, I can see the messages in the archive page now!
--

About the patch: I cannot build mainline with that due to
IXGBE_LINK_SPEED_UNKNOWN,
which is only defined as 0 in ixgbe_types.h, in ixgbe/ folder. The
ixgbevf driver has no visibility to it.

To circumvent that, I've added this define to ixgbevf/defines.h and it worked.
Other than that, patch looks good.

Feel free to add:
Reviewed-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

cheers,

Guilherme
