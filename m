From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 5 Sep 2019 15:13:18 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next] ixgbe: fix xdp handle
 calculations
In-Reply-To: <20190905011217.3567-1-kevin.laatz@intel.com>
References: <20190905011217.3567-1-kevin.laatz@intel.com>
Message-ID: <8f705b0a-e0e8-df0f-e5ed-e94dc809fb5c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/5/19 3:12 AM, Kevin Laatz wrote:
> Currently, we don't add headroom to the handle in ixgbe_zca_free,
> ixgbe_alloc_buffer_slow_zc and ixgbe_alloc_buffer_zc. The addition of the
> headroom to the handle was removed in
> commit d8c3061e5edd ("ixgbe: modify driver for handling offsets"), which
> will break things when headroom isvnon-zero. This patch fixes this and uses
> xsk_umem_adjust_offset to add it appropritely based on the mode being run.
> 
> Fixes: d8c3061e5edd ("ixgbe: modify driver for handling offsets")
> Reported-by: Bjorn Topel <bjorn.topel@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

Applied, thanks!
