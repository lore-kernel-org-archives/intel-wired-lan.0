From: Hodek, Roman <roman.aud@siemens.com>
Date: Wed, 23 Sep 2015 12:28:19 +0200
Subject: [Intel-wired-lan] [PATCH] Re: igb: use the correct i210 register
	for EEMNGCTL
In-Reply-To: <20150918224351.5228.90499.stgit@htfujina-fc.jf.intel.com>
References: <20150918224351.5228.90499.stgit@htfujina-fc.jf.intel.com>
Message-ID: <56027EC3.9050608@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Todd!

> +s32 igb_get_cfg_done_i210(struct e1000_hw *hw)

That's of course also a possibility.

And so, the new register is coupled to PHY ID not MAC type?

Thanks!

Roman

