From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 17 Mar 2022 10:18:04 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: Fix hang during reboot/shutdown
In-Reply-To: <cc7a09c1-8e1f-bb72-c9f1-354bec9dec18@intel.com>
References: <20220317104524.2802848-1-ivecera@redhat.com>
 <20220317091104.1d911864@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <cc7a09c1-8e1f-bb72-c9f1-354bec9dec18@intel.com>
Message-ID: <20220317101804.3c4d2a70@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 17 Mar 2022 10:03:05 -0700 Tony Nguyen wrote:
> There are some additional improvements that we think can be made but we 
> need more time to analyze and test. This is probably good for you to 
> take to make into this kernel though. We will send follow on patches if 
> needed.

Sounds good, thanks!
