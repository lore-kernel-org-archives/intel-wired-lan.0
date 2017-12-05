From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 5 Dec 2017 16:24:45 +0000
Subject: [Intel-wired-lan] [next-queue 02/10] ixgbe: add ipsec register
 access routines
In-Reply-To: <1512452116-14795-3-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-3-git-send-email-shannon.nelson@oracle.com>
Message-ID: <5F6048BB-653B-4A7D-8518-2ECF04AAC9D6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> On Dec 4, 2017, at 9:35 PM, Shannon Nelson <shannon.nelson@oracle.com> wrote:
> 
> Add a few routines to make access to the ipsec registers just a little
> easier, and throw in the beginnings of an initialization.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
> drivers/net/ethernet/intel/ixgbe/Makefile      |   1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe.h       |   6 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 157 +++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |  50 ++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   1 +

<snip>

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> new file mode 100644
> index 0000000..14dd011
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -0,0 +1,157 @@
> +/*******************************************************************************
> + *
> + * Intel 10 Gigabit PCI Express Linux driver
> + * Copyright(c) 2017 Oracle and/or its affiliates. All rights reserved.

I don't think that it really makes sense to assert "All rights reserved" in something that is GPL. It makes it seem like something is being asserted that is counter to the GPL.

<snip>

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
> new file mode 100644
> index 0000000..017b13f
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
> @@ -0,0 +1,50 @@
> +/*******************************************************************************
> +
> +  Intel 10 Gigabit PCI Express Linux driver
> +  Copyright(c) 2017 Oracle and/or its affiliates. All rights reserved.

Likewise here.

-- 
Mark Rustad, Networking Division, Intel Corporation

