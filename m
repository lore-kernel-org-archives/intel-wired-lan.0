From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Mon, 25 Nov 2019 15:24:33 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: need_wakeup flag might
 not be set for Tx
In-Reply-To: <1573243090-2721-1-git-send-email-magnus.karlsson@intel.com>
References: <1573243090-2721-1-git-send-email-magnus.karlsson@intel.com>
Message-ID: <adee745d-6522-309d-a944-7a54869ac945@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Magnus,

On 2019-11-08 21:58, Magnus Karlsson wrote:
> This happens if there is at least one
> outstanding packet that has not been completed by the hardware and we
> get that corresponding completion (which will not generate an
> interrupt since interrupts are disabled in the napi poll loop) between
> the time we stopped processing the Tx completions and interrupts are
> enabled again.

> But if this completion interrupt occurs before interrupts
> are enable, we lose it
Why can't it happen for regular traffic? From your description it looks 
to me as if you can miss a completion for non-AF_XDP traffic, too. Is 
there any detail that makes this issue AF_XDP-specific?

Thanks,
Max
