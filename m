From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 9 Dec 2020 15:43:02 -0800
Subject: [Intel-wired-lan] [PATCH RESEND] e1000e: fix S0ix flow to allow
 S0i3.2 subset entry
In-Reply-To: <20201208185632.151052-1-mario.limonciello@dell.com>
References: <20201208185632.151052-1-mario.limonciello@dell.com>
Message-ID: <20201209154302.266adf70@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  8 Dec 2020 12:56:32 -0600 Mario Limonciello wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> Changed a configuration in the flows to align with
> architecture requirements to achieve S0i3.2 substate.
> 
> This helps both i219V and i219LM configurations.
> 
> Also fixed a typo in the previous commit 632fbd5eb5b0
> ("e1000e: fix S0ix flows for cable connected case").
> 
> Fixes: 632fbd5eb5b0 ("e1000e: fix S0ix flows for cable connected case").
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Applied, thank you!
