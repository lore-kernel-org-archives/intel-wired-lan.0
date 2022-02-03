From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 2 Feb 2022 16:06:31 -0800
Subject: [Intel-wired-lan] [PATCH] ice: change "can't set link" message
 to dbg level
In-Reply-To: <b25f9e524c404820b310c73012507c8e65a2ef97.1643834329.git.jtoppins@redhat.com>
References: <b25f9e524c404820b310c73012507c8e65a2ef97.1643834329.git.jtoppins@redhat.com>
Message-ID: <20220202160631.7db4e729@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed,  2 Feb 2022 15:38:49 -0500 Jonathan Toppins wrote:
> -			dev_warn(dev, "can't set link to %s, err %d aq_err %s. not fatal, continuing\n",
> +			dev_dbg(dev, "can't set link to %s, err %d aq_err %s. not fatal, continuing\n",
>  				 (ena ? "ON" : "OFF"), status,
>  				 ice_aq_str(hw->adminq.sq_last_status));

Start of continuation lines needs to be adjusted.
