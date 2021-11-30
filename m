From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 29 Nov 2021 17:17:12 -0800
Subject: [Intel-wired-lan] [PATCH net] igb: fix deadlock caused by
 taking RTNL in RPM resume path
In-Reply-To: <6bb28d2f-4884-7696-0582-c26c35534bae@gmail.com>
References: <6bb28d2f-4884-7696-0582-c26c35534bae@gmail.com>
Message-ID: <20211129171712.500e37cb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 29 Nov 2021 22:14:06 +0100 Heiner Kallweit wrote:
> -	rtnl_lock();
> +	if (!rpm)
> +		rtnl_lock();

Is there an ASSERT_RTNL() hidden in any of the below? Can we add one?
Unless we're 100% confident nobody will RPM resume without rtnl held..

>  	if (!err && netif_running(netdev))
>  		err = __igb_open(netdev, true);
>  
>  	if (!err)
>  		netif_device_attach(netdev);
> -	rtnl_unlock();
> +	if (!rpm)
> +		rtnl_unlock();
