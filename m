From: David Miller <davem@davemloft.net>
Date: Wed, 11 Oct 2017 14:19:29 -0700 (PDT)
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v4 0/6] tc-flower
 based cloud filters in i40e
In-Reply-To: <20171011205830.GD9297@nanopsycho>
References: <20171011203832.GA9297@nanopsycho>
 <20171011.134652.1653141099248918341.davem@davemloft.net>
 <20171011205830.GD9297@nanopsycho>
Message-ID: <20171011.141929.2232480660433567821.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 11 Oct 2017 22:58:30 +0200

> Well if I see classid, I expect it should refer to qdisc instance. So
> far, this has been always a case. But for some drivers, this would mean
> something totally different and unrelated. So what should I think?
> What's next? Classid could be abused to identify something else. I don't
> understand why.
> 
> classid in kernel and tclass in hw are 2 completely unrelated things.

Why do they need to be different?

It's qdisc instance in both cases.  The driver is just using it to
refer to the qdisc as offloaded in the hardware.  It's a key, nothing
more.  The context in which it is used doesn't change it's meaning.

> Why they should share the same userspace api? What am I missing that
> indicates this is not an abuse?

Why invent a completely new ID space to refer to something we exactly
have an ID for already?

This duplication for the sake of "API" makes no sense to me.

The handle is not going away.  It is not going to stop referring to
a specific qdisc.

So it's stable and appropriate to use to refer to a qdisc, whatever
operation being performed, or offload being we are going to perform of
it.

I notice you are quite feisty lately in your reviews of other people's
work, so I have to ask if things are very stressful in your life?
Please drink a nice warm cup of tea and calm down :-)
