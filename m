From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 4 Apr 2018 09:53:21 -0700
Subject: [Intel-wired-lan] [iwl next-queue PATCH 02/10] macvlan: Rename
 fwd_priv to accel_priv and add accessor function
In-Reply-To: <20180403211603.7880.2593.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211603.7880.2593.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <7b6a4392-ed51-4324-9b2e-fa483f769882@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/3/2018 2:16 PM, Alexander Duyck wrote:

[...]
>   
> +static inline void *macvlan_accel_priv(struct net_device *dev)
> +{
> +	struct macvlan_dev *macvlan = netdev_priv(dev);
> +
> +	return macvlan->accel_priv;

Perhaps a check for (macvlan == NULL) before using it?
sln

> +}
>   #endif /* _LINUX_IF_MACVLAN_H */
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
