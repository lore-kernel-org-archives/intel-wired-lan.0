From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 1 Mar 2022 18:10:59 -0800
Subject: [Intel-wired-lan] [PATCH] ice: use msleep instead of mdelay
In-Reply-To: <370e9909d8e00d4a1c8abcd405c321fc41646478.1646146125.git.jtoppins@redhat.com>
References: <370e9909d8e00d4a1c8abcd405c321fc41646478.1646146125.git.jtoppins@redhat.com>
Message-ID: <20220301181059.27021dbb@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  1 Mar 2022 09:48:45 -0500 Jonathan Toppins wrote:
> Use msleep for long delays instead of spinning in the driver.

You should add the justification for why sleeping / scheduling out 
is okay in these particular spots to the commit message.
