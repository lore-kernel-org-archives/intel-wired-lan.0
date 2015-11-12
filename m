From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 11 Nov 2015 17:35:57 -0800
Subject: [Intel-wired-lan] [net-next PATCH 2/3] ixgbe: Use __dev_uc_sync
 and __dev_uc_unsync for unicast addresses
In-Reply-To: <20151022232636.24612.12045.stgit@ahduyck-vm-fedora22>
References: <20151022232228.24612.81341.stgit@ahduyck-vm-fedora22>
 <20151022232636.24612.12045.stgit@ahduyck-vm-fedora22>
Message-ID: <20151111173557.6eb25df5@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 22 Oct 2015 16:26:36 -0700
Alexander Duyck <aduyck@mirantis.com> wrote:

> +static int ixgbe_uc_unsync(struct net_device *netdev, const unsigned char *addr)
> +{
> +	struct ixgbe_adapter *adapter = netdev_priv(netdev);
> +
> +	ixgbe_del_mac_filter(adapter, addr, VMDQ_P(0));
> +
> +	return 0;

Why add an internal function that always returns 0?
Rather than making it void.
