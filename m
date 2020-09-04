From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Fri, 4 Sep 2020 17:11:43 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 3/6] xsk: introduce
 xsk_do_redirect_rx_full() helper
In-Reply-To: <20200904135332.60259-4-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904135332.60259-4-bjorn.topel@gmail.com>
Message-ID: <20200904171143.5868999a@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri,  4 Sep 2020 15:53:28 +0200
Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The xsk_do_redirect_rx_full() helper can be used to check if a failure
> of xdp_do_redirect() was due to the AF_XDP socket had a full Rx ring.

This is very AF_XDP specific.  I think that the cpumap could likely
benefit from similar approach? e.g. if the cpumap kthread is scheduled
on the same CPU.

But for cpumap we only want this behavior if sched on the same CPU as
RX-NAPI.  This could be "seen" by the cpumap code itself in the case
bq_flush_to_queue() drops packets, check if rcpu->cpu equal
smp_processor_id().  Maybe I'm taking this too far?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

