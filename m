From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 5 Jun 2018 14:43:47 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 10/11] i40e: implement AF_XDP
 zero-copy support for Tx
In-Reply-To: <20180604120601.18123-11-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
 <20180604120601.18123-11-bjorn.topel@gmail.com>
Message-ID: <20180605144347.34351ecc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon,  4 Jun 2018 14:06:00 +0200
Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

> Here, ndo_xsk_async_xmit is implemented. As a shortcut, the existing
> XDP Tx rings are used for zero-copy. This will result in other devices
> doing XDP_REDIRECT to an AF_XDP enabled queue will have its packets
> dropped.

This behavior is problematic, because XDP Tx rings are smp_processor_id
based, and several RX queues can (via proc smp_affinity settings) be
assigned to the same CPU. Thus, other RX-queues (than the AF_XDP
enabled queue) can experience packet drops.  And other devices doing
redirect through i40e, which happen to run on a CPU which XDP Tx queue
is "hijacked" will see dropped packets.

Any plans to allocate/create a dedicated TX ring per AF_XDP socket?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
