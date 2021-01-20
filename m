From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Jan 2021 18:23:52 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 6/8] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <20210119004028.2809425-7-vinicius.gomes@intel.com>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
 <20210119004028.2809425-7-vinicius.gomes@intel.com>
Message-ID: <20210119182352.17635829@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Jan 2021 16:40:26 -0800 Vinicius Costa Gomes wrote:
> +		NL_SET_ERR_MSG(extack, "Invalid value for add-frag-size");

NL_SET_ERR_MSG_MOD
