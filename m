From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 23 Mar 2022 10:40:05 -0700
Subject: [Intel-wired-lan] [PATCH net 0/2] ice: avoid
 sleeping/scheduling in atomic contexts
In-Reply-To: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
References: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
Message-ID: <20220323104005.2a58a57c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Mar 2022 13:43:51 +0100 Alexander Lobakin wrote:
> --
> Urgent fix, would like to make it directly through -net.

You may want to use three hyphens, two hyphens mean footer.
Email clients gray those out, it's easy to miss :)
