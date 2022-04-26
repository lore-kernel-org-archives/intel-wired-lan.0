From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 26 Apr 2022 08:09:53 -0700
Subject: [Intel-wired-lan] [PATCH] drivers,
 ixgbe: show VF statistics via ethtool
In-Reply-To: <20220426084636.31609-1-mheyne@amazon.de>
References: <20220426084636.31609-1-mheyne@amazon.de>
Message-ID: <20220426080953.4e5b744d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 26 Apr 2022 08:46:35 +0000 Maximilian Heyne wrote:
> +		for (i = 0; i < adapter->num_vfs; i++) {
> +			ethtool_sprintf(&p, "VF %u Rx Packets", i);
> +			ethtool_sprintf(&p, "VF %u Rx Bytes", i);
> +			ethtool_sprintf(&p, "VF %u Tx Packets", i);
> +			ethtool_sprintf(&p, "VF %u Tx Bytes", i);
> +			ethtool_sprintf(&p, "VF %u MC Packets", i);

Please use ndo_get_vf_stats / IFLA_VF_STATS.
