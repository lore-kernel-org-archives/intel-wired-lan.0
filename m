From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 09 Nov 2020 12:48:19 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 3/6] i40e: remove unnecessary
 sw_ring access from xsk Tx
In-Reply-To: <1604498942-24274-4-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-4-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <5fa9ab136176d_8c0e208cd@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Remove the unnecessary access to the software ring for the AF_XDP
> zero-copy driver. This was used to record the length of the packet so
> that the driver Tx completion code could sum this up to produce the
> total bytes sent. This is now performed during the transmission of the
> packet, so no need to record this in the software ring.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com
