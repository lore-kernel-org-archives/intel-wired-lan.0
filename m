From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Mon, 16 Nov 2020 18:40:07 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v2 06/10] xsk: propagate
 napi_id to XDP socket Rx path
In-Reply-To: <20201116085548-mutt-send-email-mst@kernel.org>
References: <20201116110416.10719-1-bjorn.topel@gmail.com>
 <20201116110416.10719-7-bjorn.topel@gmail.com>
 <20201116064953-mutt-send-email-mst@kernel.org>
 <614a7ce4-2b6b-129b-de7d-71428f7a71f6@intel.com>
 <20201116073848-mutt-send-email-mst@kernel.org>
 <585b011f-0817-a684-d1db-125bb55741fe@intel.com>
 <20201116085548-mutt-send-email-mst@kernel.org>
Message-ID: <6dc830b3-4ca4-c349-4005-952cfa437328@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 2020-11-16 14:55, Michael S. Tsirkin wrote:
[...]
> 
> tun too ;)
> 

:-) AFAIK tun doesn't use "Rx" napi, just netif_tx_napi_add() which
doesn't generate a napi_id.
