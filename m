From: Jesse Gross <jesse@kernel.org>
Date: Sun, 15 Nov 2015 20:12:24 -0800
Subject: [Intel-wired-lan] [PATCH v5 7/7] i40e:Add geneve tunnel offload
	support
In-Reply-To: <1447632175-9477-7-git-send-email-anjali.singhai@intel.com>
References: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
 <1447632175-9477-7-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEh+42g94=wNb7wUrG49d1kBJEyVqHv_BOPurPq9rP1oPnL_fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 15, 2015 at 4:02 PM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> From: Anjali Singhai <anjali.singhai@intel.com>
>
> This patch adds driver hooks to implement ndo_ops to add/del udp
> port in the HW to identify GENEVE tunnels.
>
> Also cleans up the features_check path now that we support
> multiple udp based tunnels.
>
> Add a spin_lock to guard the common data structure for the
> udp based tunnels.

This is really minor but I think we're no longer adding a new spin
lock here so we can remove the reference from the commit message.
