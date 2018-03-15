From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 18:47:23 -0700
Subject: [Intel-wired-lan] [PATCH 2/7] ixgbe: eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <1520997629-17361-2-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-2-git-send-email-okaya@codeaurora.org>
Message-ID: <CAKgT0Ue=hYC6qRO9Z193JKKvkQtmyaXm3rcy3naxFqTRW0J_8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 13, 2018 at 8:20 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

In this patch you missed the writel at the end of ixgbe_tx_map.
