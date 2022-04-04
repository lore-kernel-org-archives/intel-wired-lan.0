From: Ivan Vecera <ivecera@redhat.com>
Date: Mon, 4 Apr 2022 17:01:28 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: arfs: fix use-after-free
 when freeing @rx_cpu_rmap
In-Reply-To: <20220404132832.1936529-1-alexandr.lobakin@intel.com>
References: <20220404132832.1936529-1-alexandr.lobakin@intel.com>
Message-ID: <20220404170128.1f8d198a@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon,  4 Apr 2022 15:28:32 +0200
Alexander Lobakin <alexandr.lobakin@intel.com> wrote:

> The CI testing bots triggered the following splat:
> 
> ...
> This is due to that free_irq_cpu_rmap() is always being called
> *after* (devm_)free_irq() and thus it tries to work with IRQ descs
> already freed. For example, on device reset the driver frees the
> rmap right before allocating a new one (the splat above).
> Make rmap creation and freeing function symmetrical with
> {request,free}_irq() calls i.e. do that on ifup/ifdown instead
> of device probe/remove/resume. These operations can be performed
> independently from the actual device aRFS configuration.
> Also, make sure ice_vsi_free_irq() clears IRQ affinity notifiers
> only when aRFS is disabled -- otherwise, CPU rmap sets and clears
> its own and they must not be touched manually.
> 
> Fixes: 28bf26724fdb0 ("ice: Implement aRFS")
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
> Netdev folks, some more urgent stuff, would like to have this in
> -net directly.
> 
> Ivan, I probably should've waited for your response regarding
> signatures, hope you'll approve this one :p Feel free to review
> and/or test.

That's ok, Alex. You did it the way I prefer :-P.
Will test.

Ivan

