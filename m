From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 26 Jan 2022 09:14:09 -0800
Subject: [Intel-wired-lan] [PATCH 2/2 net-next v6] igb: refactor XDP
 registration
In-Reply-To: <20220119145259.1790015-3-vinschen@redhat.com>
References: <20220119145259.1790015-1-vinschen@redhat.com>
 <20220119145259.1790015-3-vinschen@redhat.com>
Message-ID: <87v8y6mnby.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Corinna Vinschen <vinschen@redhat.com> writes:

> On changing the RX ring parameters igb uses a hack to avoid a warning
> when calling xdp_rxq_info_reg via igb_setup_rx_resources.  It just
> clears the struct xdp_rxq_info content.
>
> Instead, change this to unregister if we're already registered.  Align
> code to the igc code.
>
> Fixes: 9cbc948b5a20c ("igb: add XDP support")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

-- 
Vinicius
