From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Sat, 23 Jan 2021 00:13:08 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: add NULL pointer check
 before calling xdp_rxq_info_reg
In-Reply-To: <CAKgT0UcpQpGLCdRbaEzyb4Q4gC9gmefg4bMFcgrQoRwy6UJvrQ@mail.gmail.com>
References: <1611322105-30688-1-git-send-email-wangyunjian@huawei.com>
 <CAKgT0UcpQpGLCdRbaEzyb4Q4gC9gmefg4bMFcgrQoRwy6UJvrQ@mail.gmail.com>
Message-ID: <b14b76065d51d7a3242231a78f0b41c7166c0882.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-01-22 at 09:54 -0800, Alexander Duyck wrote:
> On Fri, Jan 22, 2021 at 5:29 AM wangyunjian <wangyunjian@huawei.com>
> wrote:
> > 
> > From: Yunjian Wang <wangyunjian@huawei.com>
> > 
> > The rx_ring->q_vector could be NULL, so it needs to be checked
> > before
> > calling xdp_rxq_info_reg.
> > 
> > Fixes: b02e5a0ebb172 ("xsk: Propagate napi_id to XDP socket Rx
> > path")
> > Addresses-Coverity: ("Dereference after null check")
> > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> 
> This is kind of a big escape for the driver. From what I can tell it
> looks like the "ethtool -t" test now causes a NULL pointer
> dereference.
> 
> As far as the patch itself it looks good to me. This should probably
> be pushed for any of the other Intel drivers that follow a similar
> model as I suspect they were exhibit the same symptom with "ethtool
> -t" triggering a NULL pointer dereference.

Thanks for the review Alex. We'll look into fixing the other Intel
drivers.

Thanks,
Tony
