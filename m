From: Mark Pearson <markpearson@lenovo.com>
Date: Mon, 14 Dec 2020 13:40:37 -0500
Subject: [Intel-wired-lan] Fw: [External] Re: [PATCH v4 0/4] Improve
 s0ix flows for systems i219LM
In-Reply-To: <PS2PR03MB37505A15D3C9B7505D679D7BBDC70@PS2PR03MB3750.apcprd03.prod.outlook.com>
References: <20201214153450.874339-1-mario.limonciello@dell.com>
 <80862f70-18a4-4f96-1b96-e2fad7cc2b35@redhat.com>
 <PS2PR03MB37505A15D3C9B7505D679D7BBDC70@PS2PR03MB3750.apcprd03.prod.outlook.com>
Message-ID: <ae436f90-45b8-ba70-be57-d17641c4f79d@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Hans

On 14/12/2020 13:31, Mark Pearson wrote:
> 
> 
> ------------------------------------------------------------------------
> *From:* Hans de Goede <hdegoede@redhat.com>
> *Sent:* December 14, 2020 13:24
> *To:* Mario Limonciello <mario.limonciello@dell.com>; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; Tony Nguyen <anthony.l.nguyen@intel.com>;
> intel-wired-lan at lists.osuosl.org <intel-wired-lan@lists.osuosl.org>;
> David Miller <davem@davemloft.net>; Aaron Ma <aaron.ma@canonical.com>;
> Mark Pearson <mpearson@lenovo.com>
> *Cc:* linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>;
> Netdev <netdev@vger.kernel.org>; Alexander Duyck
> <alexander.duyck@gmail.com>; Jakub Kicinski <kuba@kernel.org>; Sasha
> Netfin <sasha.neftin@intel.com>; Aaron Brown <aaron.f.brown@intel.com>;
> Stefan Assmann <sassmann@redhat.com>; darcari at redhat.com
> <darcari@redhat.com>; Yijun.Shen at dell.com <Yijun.Shen@dell.com>;
> Perry.Yuan at dell.com <Perry.Yuan@dell.com>; anthony.wong at canonical.com
> <anthony.wong@canonical.com>
> *Subject:* [External] Re: [PATCH v4 0/4] Improve s0ix flows for systems
> i219LM
> ?
> Hi All,
> 
<snip>
> 
> ###
> 
> I've added Mark Pearson from Lenovo to the Cc so that Lenovo
> can investigate this issue further.
> 
> Mark, this thread is about an issue with enabling S0ix support for
> e1000e (i219lm) controllers. This was enabled in the kernel a
> while ago, but then got disabled again on vPro / AMT enabled
> systems because on some systems (Lenovo X1C7 and now also X1C8)
> this lead to suspend/resume issues.
> 
> When AMT is active then there is a handover handshake for the
> OS to get access to the ethernet controller from the ME. The
> Intel folks have checked and the Windows driver is using a timeout
> of 1 second for this handshake, yet on Lenovo systems this is
> taking 2 seconds. This likely has something to do with the
> ME firmware on these Lenovo models, can you get the firmware
> team at Lenovo to investigate this further ?
Absolutely - I'll ask them to look into this again.

We did try to make progress with this previously - but it got a bit
stuck and hence the need for these patches....but I believe things may
have changed a bit so it's worth trying again

Mark
