From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 4 May 2022 20:16:32 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] drivers,
 ixgbe: show VF statistics
In-Reply-To: <20220503150017.16148-1-mheyne@amazon.de>
References: <20220503150017.16148-1-mheyne@amazon.de>
Message-ID: <20220504201632.2a41a3b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 3 May 2022 15:00:17 +0000 Maximilian Heyne wrote:
> +		for (i = 0; i < adapter->num_vfs; i++) {
> +			ethtool_sprintf(&p, "VF %u Rx Packets", i);
> +			ethtool_sprintf(&p, "VF %u Rx Bytes", i);
> +			ethtool_sprintf(&p, "VF %u Tx Packets", i);
> +			ethtool_sprintf(&p, "VF %u Tx Bytes", i);
> +			ethtool_sprintf(&p, "VF %u MC Packets", i);
> +		}

Please drop the ethtool stats. We've been trying to avoid duplicating
the same stats in ethtool and iproute2 for a while now.
