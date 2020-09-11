From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 11 Sep 2020 15:26:42 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <e2e637ae-8cda-c9a4-91ce-93dbd475fc0c@solarflare.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
 <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
 <20200911144207.00005619@intel.com>
 <e2e637ae-8cda-c9a4-91ce-93dbd475fc0c@solarflare.com>
Message-ID: <20200911152642.62923ba2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 11 Sep 2020 22:55:54 +0100 Edward Cree wrote:
> On 11/09/2020 22:42, Jesse Brandeburg wrote:
> > Thanks Ed, I think I might just remove the /** on that function then
> > (removing it from kdoc processing)  
> I dunno, that means
> a) kerneldoc won't generate html for this struct
> b) new additions to the struct without corresponding kerneldoc won't
> ?? generate warnings
> ?both of which are not ideal outcomes.
> I realise there's value in having totally warning-clean code, but in
> ?this case I think this one warning, even though it's indicating a
> ?toolchain problem rather than a codebase problem, should better stay
> ?(if only to put pressure on the toolchain to fix it).
> Otherwise, when and if the toolchain is fixed, what's the chance we'll
> ?remember to put the /** back?
> 
> That's just my opinion, though; I won't block patches that disagree.

"Toolchain" sounds a little grand in this context, the script that
parses kdoc does basic regexps to convert the standard kernel macros:

	# replace DECLARE_BITMAP
	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
	# replace DECLARE_HASHTABLE
	$members =~ s/DECLARE_HASHTABLE\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
	# replace DECLARE_KFIFO
	$members =~ s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
	# replace DECLARE_KFIFO_PTR
	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;

IDK if we can expect it to understand random driver's macros..


This is the only use of _MCDI_DECLARE_BUF() in the tree, how about
converting the declaration to:

#declare _MCDI_BUF_LEN(_len)   DIV_ROUND_UP(_len, 4)

	efx_dword_t txbuf[_MCDI_BUF_LEN(MC_CMD_PTP_IN_TRANSMIT_LENMAX)];

Would that work?
