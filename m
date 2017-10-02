From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 2 Oct 2017 14:56:03 +0200
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] ixgbe: Update
 adaptive ITR algorithm
In-Reply-To: <20170925215225.15616.63705.stgit@localhost.localdomain>
References: <20170925215225.15616.63705.stgit@localhost.localdomain>
Message-ID: <20171002145603.32e61b6b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 25 Sep 2017 14:55:36 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The following change is meant to update the adaptive ITR algorithm to
> better support the needs of the network. Specifically with this change what
> I have done is make it so that our ITR algorithm will try to prevent either
> starving a socket buffer for memory in the case of Tx, or overruing an Rx
> socket buffer on receive.
> 
> In addition a side effect of the calculations used is that we should
> function better with new features such as XDP which can handle small
> packets at high rates without needing to lock us into NAPI polling mode.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> So I am putting this out to a wider distribution list than normal for a
> patch like this in order to get feedback on if there are any areas I may
> have overlooked. With this patch is should address many of the performance
> limitations seen with pktgen and XDP in terms of workloads that the old
> adaptive scheme wasn't handling.

Thanks a lot Alex!

I've tested the patch with XDP redirect (map), and the issue I reported
in [1] is solved with this patch.

[1] Subject: "XDP redirect measurements, gotchas and tracepoints"
 http://lkml.kernel.org/r/20170821212506.1cb0d5d6 at redhat.com

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
