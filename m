From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 5 Sep 2019 15:13:04 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next] i40e: fix xdp handle
 calculations
In-Reply-To: <20190905011144.3513-1-kevin.laatz@intel.com>
References: <20190905011144.3513-1-kevin.laatz@intel.com>
Message-ID: <f02d5d10-f2c9-e8ad-d6fe-b7ec2d952b85@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/5/19 3:11 AM, Kevin Laatz wrote:
> Currently, we don't add headroom to the handle in i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc. The addition of the
> headroom to the handle was removed in
> commit 2f86c806a8a8 ("i40e: modify driver for handling offsets"), which
> will break things when headroom is non-zero. This patch fixes this and uses
> xsk_umem_adjust_offset to add it appropritely based on the mode being run.
> 
> Fixes: 2f86c806a8a8 ("i40e: modify driver for handling offsets")
> Reported-by: Bjorn Topel <bjorn.topel@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

Applied, thanks!
