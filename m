From: Michal Kubecek <mkubecek@suse.cz>
Date: Fri, 8 Feb 2019 15:34:03 +0100
Subject: [Intel-wired-lan] Clang warning in
 drivers/net/ethernet/intel/igc/igc_ethtool.c
In-Reply-To: <20190208050921.GA8758@archlinux-ryzen>
References: <20190208050921.GA8758@archlinux-ryzen>
Message-ID: <20190208143403.GD7035@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 07, 2019 at 10:09:21PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> After commit 8c5ad0dae93c ("igc: Add ethtool support"), Clang warns:
> 
> drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: warning: variable 'igc_priv_flags_strings' is not needed and will not be emitted [-Wunneeded-internal-declaration]
> static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
>                   ^
> 1 warning generated.
> 
> igc_priv_flags_strings is only used in an ARRAY_SIZE macro, which is a
> compile time evaluation, so no reference to it is being emitted in the
> final assembly. Is it actually needed and was forgotten to be used
> somewhere or could it be eliminated so that Clang no longer warns?

That's because the driver provides get_priv_flags() and set_priv_flags()
callbacks in its ethtool_ops to allow querying and setting legacy-rx
private flag but it does not provide get_sset_count() and get_strings()
to provide list of private flags to userspace ethtool.

Michal Kubecek
