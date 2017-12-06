From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 6 Dec 2017 10:47:47 +0100
Subject: [Intel-wired-lan] [PATCH] e1000e: Taint a HW lockup
In-Reply-To: <151249715301.700.15883625561601294827@mail.alporthouse.com>
References: <20171205180000.23637-1-chris@chris-wilson.co.uk>
 <151249715301.700.15883625561601294827@mail.alporthouse.com>
Message-ID: <CAKMK7uGL4-qM=in3TiHfsJz-sJQRTMx+xRnh7MbXNmUBhskaOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 5, 2017 at 7:05 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Chris Wilson (2017-12-05 18:00:00)
>> When we see an e1000e HW lockup in CI, it is typically fatal with the
>> hang repeating until the host is forcibly rebooted. Speed up that
>> process by tainting the kernel, which CI can trivially detect (and is
>> being used to detect similarly fatal CI conditions) and reboot soon
>> after.
>>
>> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Tomi Sarvela <tomi.p.sarvela@intel.com>
>
> I'm not concerned on selling this to e1000e, but if it helps improving
> CI robustness, then topic/core-for-CI. Or maybe we should create a new
> topic, Daniel? topic/taints-for-CI?

Sounds like a usable idea for CI. Would be especially interesting
because despite applying the suggested w/a, we still hit lockups.
Before we do that though I think we should get an ack from the e1000e
team. Jani S. maybe something you can driver?

Adding more folks to cc.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
