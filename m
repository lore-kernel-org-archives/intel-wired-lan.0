From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 6 Jun 2016 17:38:27 +0000
Subject: [Intel-wired-lan] [PATCH v1 09/18] fm10k: wait for queues to
 drain fully before stop_hw
In-Reply-To: <20160603224228.10192-10-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
 <20160603224228.10192-10-jacob.e.keller@intel.com>
Message-ID: <1465234707.28126.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-06-03 at 15:42 -0700, Jacob Keller wrote:
> It turns out that VFs also suffer from the same queue issue as PFs,
> and
> can't simply perform a datapath reset. Add a looping delay for
> queueus
> which will sleep and then check the queues to see if they are drained
> before calling stop_hw. If they take longer than 50 loops (~500ms,
> longest delay I found necessary while testing), issue a dev_err
> message
> and continue with the reset. For PFs, this should trigger a datapath
> reset and a recovery. For VFs this will likely cause the VF to be
> stuck
> and need re-creating. Unfortunately there isn't anything else the
> driver
> can do in response.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
It looks like after some testing, this patch may need changes.

Thanks,
Jake
