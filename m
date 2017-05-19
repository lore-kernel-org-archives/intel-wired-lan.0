From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 19 May 2017 11:34:43 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: use disable_hardirq() also
	for MSIX vectors in e1000_netpoll()
In-Reply-To: <149517832870.37403.16008624383220981105.stgit@buzz>
References: <149517832870.37403.16008624383220981105.stgit@buzz>
Message-ID: <CAM_iQpUD9qJepFn-8M32+VcureTgM77-beY9=+tm0jC7Btkg7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 19, 2017 at 12:18 AM, Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> Replace disable_irq() which waits for threaded irq handlers with
> disable_hardirq() which waits only for hardirq part.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 311191297125 ("e1000: use disable_hardirq() for e1000_netpoll()")

Thomas had a similar patch, I don't know why he never sends it
out formally. Anyway,

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
