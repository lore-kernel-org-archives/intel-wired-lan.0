From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 7 Feb 2019 22:09:21 -0700
Subject: [Intel-wired-lan] Clang warning in
 drivers/net/ethernet/intel/igc/igc_ethtool.c
Message-ID: <20190208050921.GA8758@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

After commit 8c5ad0dae93c ("igc: Add ethtool support"), Clang warns:

drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: warning: variable 'igc_priv_flags_strings' is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
                  ^
1 warning generated.

igc_priv_flags_strings is only used in an ARRAY_SIZE macro, which is a
compile time evaluation, so no reference to it is being emitted in the
final assembly. Is it actually needed and was forgotten to be used
somewhere or could it be eliminated so that Clang no longer warns?

Thanks,
Nathan
