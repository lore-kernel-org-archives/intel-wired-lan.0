From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 28 Aug 2021 23:55:53 +0200
Subject: [Intel-wired-lan] [RFC net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <20210828211248.3337476-2-maciej.machnikowski@intel.com>
References: <20210828211248.3337476-1-maciej.machnikowski@intel.com>
 <20210828211248.3337476-2-maciej.machnikowski@intel.com>
Message-ID: <YSqw6aJRrWbxRaas@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Aug 28, 2021 at 11:12:47PM +0200, Maciej Machnikowski wrote:
> This patch adds the new RTM_GETSYNCESTATE message to query the status
> of SyncE syntonization on the device.

Hi Maciej

You use syntonization a few times. Is this a miss spelling for
synchronisation, or a SyncE terms?

> @@ -193,7 +196,7 @@ enum {
>  #define RTM_NR_FAMILIES	(RTM_NR_MSGTYPES >> 2)
>  #define RTM_FAM(cmd)	(((cmd) - RTM_BASE) >> 2)
>  
> -/* 
> +/*
>     Generic structure for encapsulation of optional route information.
>     It is reminiscent of sockaddr, but with sa_family replaced
>     with attribute type.
> @@ -233,7 +236,7 @@ struct rtmsg {
>  
>  	unsigned char		rtm_table;	/* Routing table id */
>  	unsigned char		rtm_protocol;	/* Routing protocol; see below	*/
> -	unsigned char		rtm_scope;	/* See below */	
> +	unsigned char		rtm_scope;	/* See below */
>  	unsigned char		rtm_type;	/* See below	*/
>  
>  	unsigned		rtm_flags;
> @@ -555,7 +558,7 @@ struct ifinfomsg {
>  };
>  
>  /********************************************************************
> - *		prefix information 
> + *		prefix information
>   ****/
>  
>  struct prefixmsg {
> @@ -569,7 +572,7 @@ struct prefixmsg {
>  	unsigned char	prefix_pad3;
>  };
>  
> -enum 
> +enum
>  {
>  	PREFIX_UNSPEC,
>  	PREFIX_ADDRESS,

You appear to have a number of white space changes here. Please put
them into a separate patch, or drop them.

     Andrew
