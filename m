From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 23 May 2017 18:43:48 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: use disable_hardirq() also
 for MSIX vectors in e1000_netpoll()
In-Reply-To: <CAM_iQpUD9qJepFn-8M32+VcureTgM77-beY9=+tm0jC7Btkg7Q@mail.gmail.com>
References: <149517832870.37403.16008624383220981105.stgit@buzz>
 <CAM_iQpUD9qJepFn-8M32+VcureTgM77-beY9=+tm0jC7Btkg7Q@mail.gmail.com>
Message-ID: <889b47a8-6b52-bf90-6a0d-823e9b03361e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/19/2017 21:34, Cong Wang wrote:
> On Fri, May 19, 2017 at 12:18 AM, Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>> Replace disable_irq() which waits for threaded irq handlers with
>> disable_hardirq() which waits only for hardirq part.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Fixes: 311191297125 ("e1000: use disable_hardirq() for e1000_netpoll()")
> Thomas had a similar patch, I don't know why he never sends it
> out formally. Anyway,
>
> Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Ack. Let's pick up this patch.

